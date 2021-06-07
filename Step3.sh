for i in `cat gene.txt`;do

cd ${i}
bsub -J eQTL -n 1 -R span[hosts=1] -o %J.out -e %J.err -q q2680v2 \
"emmax -v -d 10 -t emmax_genotype -o $i -p ${i}.txt -k emmax_genotype.BN.kinf -c ../emmax.cov.txt"
cd ../

done
# gene.txt中包含要做eQTL基因的名字，每个一行
#gene.txt
#Zm00001d000004.txt
#Zm00001d000080.txt
#Zm00001d000099.txt
#Zm00001d000133.txt

#结果会得到每个性状（每个基因表达量）关联分析的结果文件
#例如：#Zm00001d000004.ps, Zm00001d000080.ps, Zm00001d000099.ps, Zm00001d000133.ps
for i in *ps;do
name=${i%.ps}
#echo $name
awk 'BEGIN{FS="\t";OFS="\t"}{if($3<=6.18192159e-7){print "'"${name}"'",$1,$3}}' $i >> eQTL.txt
done
#将显著的SNP都提取出来，其中每个.ps文件第三列是该标记的显著性
#6.18192159e-7是校正多重比较后的显著性阈值（0.05/标记数）
#eQTL.txt文件包含三列，基因，显著的标记，显著性
awk 'BEGIN{FS="\t"}{if($3=="gene"){print $0}}' ~/ref/Zea_mays.B73_RefGen_v4.50.gtf > gene.txt
#将基因组注释中的基因注释提取出来
for i in `awk 'BEGIN{FS="\t"}{print $1}' eQTL.txt`;do
grep $i gene.txt|awk 'BEGIN{FS="\t"}{print "'"${i}"'",$4,$5}' >> position.txt
done
#将基因的起始终止位置都提取出来放到position.txt里面
python3 merge.py
#这里最终得到一个eQTL_plot.csv文件其中包含了基因，基因的物理位置，标记，标记的物理位置，显著性等信息，用于绘图。
