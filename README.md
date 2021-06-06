# eQTL-analysis
Expression quantitative traits locus analysis using EMMAX software

# step1
Download RNA-seq and genome-wide marks from public database.

The marks file in VCF format is from Yan's Lab website: http://www.maizego.org/

The RNA-seq data of kernel in 15 DAP were downloaded from NCBI.

Reference: Liu H, Luo X, Niu L, Xiao Y, Chen L, Liu J, Wang X, Jin M, Li W, Zhang Q, Yan J. Distant eQTLs and Non-coding Sequences Play Critical Roles in Regulating Gene Expression and Quantitative Trait Variation in Maize. Mol Plant. 2017 Mar 6;10(3):414-426. doi: 10.1016/j.molp.2016.06.016. Epub 2016 Jul 2. PMID: 27381443.

# Step1
QC, mapping and calculate the expression level of genes in each sample.

Merge expression level of each gene in different samples to one file.

# Step2
Filter marks of 368 maize inbred lines

# Step3
Using Genome-wide association stduy, identify significant marks for eacho genes.

# Step4
Visualization using R.
