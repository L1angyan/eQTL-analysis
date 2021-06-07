import pandas as pd

df1 = pd.read_table("eQTL.txt",header=None,sep="\t")
df1.columns = ["gene","marker","significance"]
df2 = pd.read_table("position.txt",header=None,sep="\t")
df2.columns = ["gene","gene_chr","gene_start","gene_end"]

df = df.merge(df1,df2,on="gene",how="inner")
df.to_csv("eQTL_plot.csv",index=None)
