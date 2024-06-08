import numpy as np
import pandas as pd 
import seaborn as sns
import matplotlib.pyplot as plt
import sklearn.preprocessing as preprocessing

df = pd.read_csv("./diabetes.csv")

print(df.shape)
print(df['Pregnancies'].value_counts(dropna=False)) #dropna = False eksik değerlerin dahil edilmesini sağlar

df.head()
df.tail()
df.isnull().sum()
df.describe()
df.hist(figsize=(10,10))

fig = plt.figure(figsize =(10, 10))
ax = fig.add_axes([0, 0, 1, 1]) # type: ignore
bp = ax.boxplot(df)

plt.show()

from sklearn.svm import OneClassSVM

data_new=df.copy()
ee = OneClassSVM(nu=0.1)  #hata marjını ayarlıyoruz
ee.fit_predict(data_new)  # Aykırı olmayanlar 1 olarak etiketlenirken, aykırı olanlar -1 olarak etiketlenir.
pred = ee.predict(data_new) #OneClassSVM modeli temsil edilir. data_new verisindeki 1 (normal) ve -1 (aykırı) değerleri sınıflanır
data_new['anomaly']=pred #data_new verisine "anomaly" sütunu eklenir. bir üst satırda elde edilen veriler bu sütuna eklenir.
outliers=data_new.loc[data_new['anomaly']==-1]  #aykırı olan veriler ayrı bir veri çerçevesine (outliers) kopyalanır.
outlier_index=list(outliers.index)  #aykırı olan verilerin indeksleri bir liste olarak alınır.

print(data_new['anomaly'].value_counts())   #aykırı olmayan ve aykırı olan verilerin sayısı görüntülenir.

data_new = data_new[data_new.anomaly != -1]  #1 (normal) değerleri için True -1 (aykırı) değerleri için False döndürür
#aykırı değerlerin veriden silinmesini sağlar
fig = plt.figure(figsize =(10, 7))
ax = fig.add_axes([0, 0, 1, 1]) # type: ignore
bp = ax.boxplot(data_new)
plt.show()


data_new["DiabetesPedigreeFunction"].hist()
pt = preprocessing.PowerTransformer(method='box-cox')
data_new["DiabetesPedigreeFunction"]=pt.fit_transform(data_new["DiabetesPedigreeFunction"].to_numpy().reshape(-1, 1)+0.001)
data_new["DiabetesPedigreeFunction"].hist()