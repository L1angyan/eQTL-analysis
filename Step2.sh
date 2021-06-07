# In this step, I will filter the markers for association-mapping 
# Preparing covariance to avoid the bias from population structure and kinship. (Q+K model)

module load tassel/5
run_pipeline.pl -Xms30g -Xmx30g -fork1 -h sortV4SNP1.25M.hmp.txt -export -exportType VCF -runfork1
# Using tassel software convert genome-wide markers in hapmap format to vcf format.
# 将标记从hapmap格式转为vcf格式
# sortV4SNP1.25M.hmp.txt was downloaded from http://www.maizego.org/

module load VCFtools/0.1.16
vcftools --gzvcf sortV4SNP1.vcf.gz --remove-indels \
--min-alleles 2 --max-alleles 2 --recode --keep sample.txt --out 368
# 只留下2个allele的SNP标记，且只保留368份材料的标记
#该文件包含了540份材料的变异数据，只保留我们感兴趣的368份材料的数据,sample.txt包含了我们需要保留的样本的ID，每个样本一行
#--recode输出.recode.vcf代表输出通过筛选的内容,--keep file保留file中的snp，--out输出前缀
vcftools --vcf 368.recode.vcf --freq --out freq
#--freq,输出等位基因频率
vcftools --vcf 368.recode.vcf --maf 0.05 --recode --out 368_maf_filter
#maf=0.05,maf小于0.05的snp被过滤掉

plink --vcf 368_maf_filter.recode.vcf --maf 0.05 --geno 0.1 --mind 0.7 \
--recode vcf-iid --out after_filter --allow-extra-chr
#过滤snp和个体并输出vcf格式
#--recode vcf-iid即给snp加上ID，
#--allow-extra-chr，因为基因组组装不完整，有些contig无法挂载到染色体上，位于这些contig上的标记需要通过该参数才会被保留。
plink --vcf after_filter.vcf --indep-pairwise 50 10 0.2 \
--out LD_prune --allow-extra-chr
#prune，输出LD_prune.prune.in为需要的不连锁的标记
plink --vcf after_filter.vcf --make-bed \
--extract LD_prune.prune.in --out after_prune --allow-extra-chr
#提取不连锁的标记，并输出为plink格式
plink --bfile after_prune \
--recode vcf-iid --out after_prune --allow-extra-chr
#plink格式的过滤后标记转为vcf格式，得到after_pune.vcf
plink -bfile after_prune \
--recode 12 --out admixture --allow-extra-chr
#plink格式过滤后的标记转为admixture格式
plink --vcf after_prune.vcf \
--recode 12 --output-missing-genotype 0 --transpose \
--out emmax_genotype --allow-extra-chr
#过滤后的vcf格式标记转为emmax格式
#得到emmax_genotype.tfam, emmax_genotype.ped, emmax_genotype.map文件
conda install emmax
emmax-kin emmax_genotype -v -d 10 -o emmax_genotype.aBN.kinf
#emmax建立亲缘关系矩阵

for i in {1..15};do
admixture --cv admixture.ped ${i} -j10 >> log.txt
done
#admixture尝试分群，用CV error最小的分群数目，用对应的文件用作后续分析
#K=10时，CV error最下，因此将输出的admixture.10.Q用于下一步群体结构的分析
echo "<Covariate>\n<Trait>\tQ1\tQ2\tQ3\tQ4\tQ5\tQ6\tQ7\tQ8\tQ9" > 10.Q
for i in `awk 'BEGIN{FS="\t"}{print $1}' admixture.ped`;do
awk 'BEGIN{FS="\t";OFS="\t"}{print "'"${i}"'"}{for(j=1;j<=9;j++){print $j}}' >> 10.Q
done
#删除admixture.10.Q的最后一列并给它加上表头以便后续使用
