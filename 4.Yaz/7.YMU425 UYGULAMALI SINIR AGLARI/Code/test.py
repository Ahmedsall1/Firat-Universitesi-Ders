import cv2
import mediapipe as mp
import torch
import torch.nn as nn
from torch.utils.data import Dataset, DataLoader
import numpy as np

class LipDataset(Dataset):
    def __init__(self, video_paths, labels, transform=None):
        self.video_paths = video_paths
        self.labels = labels
        self.transform = transform
        
    def __len__(self):
        return len(self.video_paths)
    
    def __getitem__(self, idx):
        video_path = self.video_paths[idx]
        # Video okuma ve dudak bölgesi çıkarma işlemleri
        lip_frames = self.extract_lip_frames(video_path)
        
        if self.transform:
            lip_frames = self.transform(lip_frames)
            
        return lip_frames, self.labels[idx]
    
    def extract_lip_frames(self, video_path):
        mp_face_mesh = mp.solutions.face_mesh
        face_mesh = mp_face_mesh.FaceMesh(
            max_num_faces=1,
            refine_landmarks=True,
            min_detection_confidence=0.5,
            min_tracking_confidence=0.5
        )
        
        cap = cv2.VideoCapture(video_path)
        frames = []
        
        while cap.isOpened():
            ret, frame = cap.read()
            if not ret:
                break
                
            # MediaPipe ile dudak bölgesi tespiti
            results = face_mesh.process(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB))
            if results.multi_face_landmarks:
                landmarks = results.multi_face_landmarks[0]
                # Dudak landmark'ları (61-68 arası)
                lip_points = np.array([[landmarks.landmark[i].x * frame.shape[1],
                                      landmarks.landmark[i].y * frame.shape[0]] 
                                     for i in range(61, 69)], np.int32)
                
                # Dudak ROI çıkarma
                x, y, w, h = cv2.boundingRect(lip_points)
                lip_roi = frame[y:y+h, x:x+w]
                lip_roi = cv2.resize(lip_roi, (88, 88))  # Sabit boyut
                frames.append(lip_roi)
                
        cap.release()
        return np.array(frames)

# Model tanımı
class LipReadingModel(nn.Module):
    def __init__(self, num_classes):
        super(LipReadingModel, self).__init__()
        self.vit = torch.hub.load('facebookresearch/deit:main', 
                                'deit_tiny_patch16_224', 
                                pretrained=True)
        self.vit.head = nn.Linear(192, num_classes)
        
    def forward(self, x):
        return self.vit(x)

def train_model(model, train_loader, criterion, optimizer, num_epochs):
    device = torch.device("mps" if torch.backends.mps.is_available() else "cpu")
    model = model.to(device)
    
    for epoch in range(num_epochs):
        model.train()
        running_loss = 0.0
        
        for inputs, labels in train_loader:
            inputs = inputs.to(device)
            labels = labels.to(device)
            
            optimizer.zero_grad()
            outputs = model(inputs)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()
            
            running_loss += loss.item()
            
        print(f'Epoch {epoch+1}, Loss: {running_loss/len(train_loader)}')