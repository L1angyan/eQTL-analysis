import sys
import pandas as pd

f = sys.argv[2:]
df = pd.read_table(sys.argv[1],sep="\t")
for i in f:
    df1 = pd.read_table(i,sep="\t")
    df = pd.merge(df,df1,how="inner",on="gene")

(df.T).to_csv("zzz_368.txt",sep="\t",index=None)
