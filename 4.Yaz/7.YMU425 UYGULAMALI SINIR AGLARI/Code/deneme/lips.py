import cv2
import numpy as np
import mediapipe as mp
from pathlib import Path
import torch
import torch.nn as nn
from torch.utils.data import Dataset, DataLoader

class LipDetector:
    """Görüntüden dudak bölgesini tespit eden ve çıkaran sınıf"""
    def __init__(self, target_size=(88, 88)):
        # MediaPipe yüz mesh'ini başlat
        self.mp_face_mesh = mp.solutions.face_mesh.FaceMesh(
            max_num_faces=1,  # Sadece bir yüz tespit et
            refine_landmarks=True,  # Daha detaylı landmark'lar
            min_detection_confidence=0.5,
            min_tracking_confidence=0.5
        )
        self.target_size = target_size
        
    def detect_lips(self, image):
        """
        Görüntüden dudak bölgesini tespit et ve çıkar
        
        Parameters:
            image: np.array - OpenCV formatında görüntü (BGR)
            
        Returns:
            np.array - Dudak bölgesi (ROI) veya None
        """
        # Görüntüyü RGB'ye çevir (MediaPipe RGB bekler)
        rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        
        # MediaPipe ile yüz landmark'larını tespit et
        results = self.mp_face_mesh.process(rgb_image)
        
        if results.multi_face_landmarks:
            landmarks = results.multi_face_landmarks[0]  # İlk yüz
            
            # Dudak landmark'ları (48-68 arası noktalar dudak bölgesini temsil eder)
            lip_points = np.array([[landmarks.landmark[i].x * image.shape[1],
                                  landmarks.landmark[i].y * image.shape[0]] 
                                 for i in range(48, 68)], np.int32)
            
            # Dudak bölgesini kırp
            x, y, w, h = cv2.boundingRect(lip_points)
            
            # Biraz padding ekle
            padding = 10
            x = max(0, x - padding)
            y = max(0, y - padding)
            w = min(image.shape[1] - x, w + 2 * padding)
            h = min(image.shape[0] - y, h + 2 * padding)
            
            lip_roi = image[y:y+h, x:x+w]
            
            # Sabit boyuta getir
            lip_roi = cv2.resize(lip_roi, self.target_size)
            return lip_roi
        return None

class LipDataset(Dataset):
    """Dudak görüntüleri ve harfler için veri seti sınıfı"""
    def __init__(self, data_path, labels_path, transform=None):
        """
        Parameters:
            data_path: str - Dudak görüntülerinin bulunduğu klasör
            labels_path: str - Etiketlerin (harflerin) bulunduğu dosya
            transform: callable - Veri artırma işlemleri
        """
        self.data_path = Path(data_path)
        self.transform = transform
        self.images = []
        self.labels = []
        
        # Veriyi yükle
        self._load_data()
        
    def _load_data(self):
        """Görüntüleri ve etiketleri yükle"""
        # TODO: Veri setinize göre bu fonksiyonu düzenleyin
        for img_path in self.data_path.glob('*.jpg'):
            self.images.append(str(img_path))
            # Etiket dosyasından harfi oku
            label = self._get_label(img_path.stem)
            self.labels.append(label)
    
    def __len__(self):
        return len(self.images)
    
    def __getitem__(self, idx):
        # Görüntüyü oku
        image = cv2.imread(self.images[idx])
        label = self.labels[idx]
        
        if self.transform:
            image = self.transform(image)
            
        return image, label

class LipToLetterModel(nn.Module):
    """Dudak görüntüsünden harf tahmin eden model"""
    def __init__(self, num_classes):
        """
        Parameters:
            num_classes: int - Çıkış sınıf sayısı (harf sayısı)
        """
        super().__init__()
        
        # Temel CNN mimarisi
        self.features = nn.Sequential(
            # Giriş: 3x88x88
            nn.Conv2d(3, 64, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2),  # 64x44x44
            
            nn.Conv2d(64, 128, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2),  # 128x22x22
            
            nn.Conv2d(128, 256, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2),  # 256x11x11
        )
        
        # Sınıflandırıcı
        self.classifier = nn.Sequential(
            nn.Flatten(),
            nn.Linear(256 * 11 * 11, 512),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.Linear(512, num_classes)
        )
        
    def forward(self, x):
        x = self.features(x)
        x = self.classifier(x)
        return x

def train_model(model, train_loader, criterion, optimizer, num_epochs=10):
    """Model eğitim fonksiyonu"""
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    model = model.to(device)
    
    for epoch in range(num_epochs):
        model.train()
        running_loss = 0.0
        
        for images, labels in train_loader:
            images = images.to(device)
            labels = labels.to(device)
            
            optimizer.zero_grad()
            outputs = model(images)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()
            
            running_loss += loss.item()
            
        print(f'Epoch {epoch+1}, Loss: {running_loss/len(train_loader)}')