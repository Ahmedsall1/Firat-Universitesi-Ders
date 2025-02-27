import cv2
import numpy as np
from pathlib import Path
import mediapipe as mp
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.utils.data import Dataset, DataLoader
from transformers import AutoTokenizer

class LipFeatureExtractor:
    def __init__(self, target_size=(88, 88)):
        self.target_size = target_size
        self.mp_face_mesh = mp.solutions.face_mesh.FaceMesh(
            max_num_faces=1,
            refine_landmarks=True,
            min_detection_confidence=0.5,
            min_tracking_confidence=0.5
        )
    
    def extract_lips(self, image):
        rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        results = self.mp_face_mesh.process(rgb_image)
        
        if results.multi_face_landmarks:
            landmarks = results.multi_face_landmarks[0]
            # Dudak landmarkları (48-68 arası)
            lip_points = np.array([[landmarks.landmark[i].x * image.shape[1],
                                  landmarks.landmark[i].y * image.shape[0]] 
                                 for i in range(48, 68)], np.int32)
            
            x, y, w, h = cv2.boundingRect(lip_points)
            padding = 10
            x = max(0, x - padding)
            y = max(0, y - padding)
            w = min(image.shape[1] - x, w + 2 * padding)
            h = min(image.shape[0] - y, h + 2 * padding)
            
            lip_roi = image[y:y+h, x:x+w]
            lip_roi = cv2.resize(lip_roi, self.target_size)
            return lip_roi
        return None

class LipReadingDataset(Dataset):
    def __init__(self, data_dir, label_map, transform=None, max_seq_length=50):
        self.data_dir = Path(data_dir)
        self.label_map = label_map
        self.transform = transform
        self.max_seq_length = max_seq_length
        self.samples = self._load_samples()
        
    def _load_samples(self):
        samples = []
        # F01/words/01/01 gibi klasörleri tara
        for speaker_dir in self.data_dir.glob("F*/words/*/*/*"):
            if speaker_dir.is_dir():
                label = speaker_dir.parent.parent.name  # kelime/ifade etiketi
                if label in self.label_map:
                    samples.append({
                        'path': speaker_dir,
                        'label': self.label_map[label]
                    })
        return samples
    
    def __len__(self):
        return len(self.samples)
    
    def __getitem__(self, idx):
        sample = self.samples[idx]
        frames = []
        
        # Sıralı görüntüleri yükle
        for img_path in sorted(sample['path'].glob('*.jpg')):
            image = cv2.imread(str(img_path))
            if image is not None and self.transform:
                image = self.transform(image)
                frames.append(image)
        
        # Sabit uzunluğa getir
        if len(frames) > self.max_seq_length:
            frames = frames[:self.max_seq_length]
        else:
            # Padding ekle
            padding = [frames[-1]] * (self.max_seq_length - len(frames))
            frames.extend(padding)
            
        return torch.stack(frames), sample['label']

class LipReadingModel(nn.Module):
    def __init__(self, num_classes, hidden_dim=512):
        super().__init__()
        
        # 3D CNN
        self.conv3d = nn.Sequential(
            nn.Conv3d(3, 64, kernel_size=(3, 7, 7), stride=(1, 2, 2), padding=(1, 3, 3)),
            nn.BatchNorm3d(64),
            nn.ReLU(),
            nn.MaxPool3d(kernel_size=(1, 2, 2), stride=(1, 2, 2))
        )
        
        # BiLSTM
        self.lstm = nn.LSTM(input_size=64*22*22,  # CNN çıkış boyutu
                           hidden_size=hidden_dim,
                           num_layers=2,
                           batch_first=True,
                           bidirectional=True)
        
        # Sınıflandırma katmanı
        self.fc = nn.Linear(hidden_dim*2, num_classes)
        
    def forward(self, x):
        batch_size, seq_len, c, h, w = x.size()
        
        # 3D CNN
        x = self.conv3d(x)
        
        # LSTM için yeniden boyutlandır
        x = x.permute(0, 2, 1, 3, 4)  # (batch, seq, channels, height, width)
        x = x.contiguous().view(batch_size, seq_len, -1)
        
        # BiLSTM
        x, _ = self.lstm(x)
        
        # Son zaman adımını al
        x = x[:, -1, :]
        
        # Sınıflandırma
        x = self.fc(x)
        return x

def create_label_map(data_dir):
    """Veri setinden etiket haritası oluştur"""
    words = set()
    for word_dir in Path(data_dir).glob("F*/words/*"):
        if word_dir.is_dir():
            words.add(word_dir.name)
    return {word: idx for idx, word in enumerate(sorted(words))}

def predict_from_video(model, video_path, label_map_reverse, feature_extractor):
    """Video'dan dudak okuma yap"""
    cap = cv2.VideoCapture(video_path)
    frames = []
    
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break
            
        lip_roi = feature_extractor.extract_lips(frame)
        if lip_roi is not None:
            lip_roi = cv2.resize(lip_roi, (88, 88))
            frames.append(torch.from_numpy(lip_roi).permute(2, 0, 1))
            
    cap.release()
    
    if len(frames) > 0:
        # Model tahminini al
        with torch.no_grad():
            x = torch.stack(frames).unsqueeze(0)  # (1, seq_len, channels, height, width)
            output = model(x)
            pred = torch.argmax(output, dim=1)
            return label_map_reverse[pred.item()]
    
    return None

# Etiket haritası oluştur
data_dir = "/data"
label_map = create_label_map(data_dir)
label_map_reverse = {v: k for k, v in label_map.items()}

# Dataset oluştur
dataset = LipReadingDataset(data_dir, label_map)