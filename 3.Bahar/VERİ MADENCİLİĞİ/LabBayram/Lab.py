import pandas as pd
from mlxtend.preprocessing import TransactionEncoder 
from mlxtend.frequent_patterns import apriori
df =pd.read_csv("B:\\ABCDE\\3.Sınıf\\Bahar\\VERİ MADENCİLİĞİ\\LabBayram\\GroceryStoreDataSet.csv",names=['products'], header=None)
df.head(10)
df.shape
df.columns
data = list (df['products'].apply(lambda x:x.split(',')))
data



te = TransactionEncoder()
te_data=te.fit(data).transform(data)
df=pd.DataFrame(te_data,columns=te.columns_)
df

df1= apriori(df,min_support=0.02 , use_colnames=True,verbose=1)

df1.sort_values(by="support",ascending=False)

from mlxtend.frequent_patterns import association_rules

association_rules(df1,metric="confidence",min_threshold=0.6)