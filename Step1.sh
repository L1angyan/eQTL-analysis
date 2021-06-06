module load sratoolkit/2.9.6
prefetch `cat sra.txt`
for i in *.sra;do
fastq-dump --split-3 -gzip $i
done
#Download RNA-seq data

module load fastp/0.20.0

for i in *_;do
name=${i%_}
cd $i
fq1=${name}_1.fq.gz
fq2=${name}_2.fq.gz
out1=${name}_1.clean.fq.gz
out2=${name}_2.clean.fq.gz

bsub -J qc -n 3 -R span[hosts=1] -o %J.out -e %J.err -q normal \
"fastp -i $fq1 -I $fq2 -o ../../clean/$out1 -O ../../clean/$out2 -5 -3 -w 3;\
mv ${name}* ../"
cd ../
done
#Quality control, using Fastp software
