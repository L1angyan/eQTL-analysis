tfam <- read.table("emmax_genotype.tfam", header = F, stringsAsFactors = F)
admix <- read.table("10.Q", header = T, check.names = F, stringsAsFactors = F, skip = 1)
admix <- admix[match(tfam$V1, admix$`<Trait>`), ]
admix <- cbind(admix[,1], admix[,1], rep(1, nrow(admix)), admix[,-1]) 
write.table(admix, file = "emmax.cov.txt", col.names = F, row.names = F, sep = "\t", quote = F)
#将tfam（包含家系，性别等等信息）和10.Q（群体结构信息）合并形成协变量文件用于关联分析。
