import sys
import pandas as pd

f = sys.argv[2:]
df = pd.read_table(sys.argv[1],sep="\t")
for i in f:
    df1 = pd.read_table(i,sep="\t")
    df = pd.merge(df,df1,how="inner",on="gene")

df = df.T
for i in range(1,len(df.columns)):
    name=df.columns[i]+".txt"
    df.iloc[:,[0,0,i].to_csv(name,sep="\t",index=None,header=None)
