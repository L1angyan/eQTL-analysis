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

for i in *_1.clean.fq.gz;do
name=${i%_*}
mkdir ${name}_
cd ${name}_
hisat2 -p 5 --dta -x ~/ly/peptide/zhushi/m_hisat2/M_index -1 ../${name}_1.clean.fq.gz -2 ../${name}_2.clean.fq.gz -S ${name}.sam; 
samtools sort -@ 5 -o ${name}_sorted.bam ${name}.sam; 
cufflinks ${name}_sorted.bam -G ~/ly/peptide/zhushi/maize_merge.gtf -p 5 -L ${name}_cuff;
mv genes.fpkm_tracking ${name}.txt
cd ../
done
#Mapping and calculate genes' expression level
#

for i in *txt;do
name=${i%.txt}
awk 'BEGIN{FS="\t";print gene"\t"${name}}{if($0!~"FPKM"){print $1,$10}}' $i > ${name}.express.txt
done
#将输出的表达量文件改成我们需要的格式，第一列：基因名，第二列：表达量（FPKM）
string="";
for i in *.txt;do 
string=${string}" "${i}
done
python3 zzz_merge.py $string
#制作表达量表型文件
#例如Zm00001d054107.txt文件内容为
#05W002  05W002  8.70442e-09
#05WN230 05WN230 3.38878e-47
#07KS4   07KS4   1.78264e-06
#1462    1462    0.298945
#150     150     7.37163e-12
#177     177     0.587968
#18-599  18-599  0.330502
#238     238     0.0685451
#......
#这里就已经准备好了输入所需要的表型文件
