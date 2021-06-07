library(ggplot2)
setwd("D:/workspace/")
df = read.csv("eQTL_noCT.csv")
df[df$chr_trans==2,"trans_position"]=df[df$chr_trans==2,"trans_position"]+307041717
df[df$chr_snp==2,"position"]=df[df$chr_snp==2,"position"]+307041717
df[df$chr_trans==3,"trans_position"]=df[df$chr_trans==3,"trans_position"]+551483993
df[df$chr_snp==3,"position"]=df[df$chr_snp==3,"position"]+551483993
df[df$chr_trans==4,"trans_position"]=df[df$chr_trans==4,"trans_position"]+787151827
df[df$chr_snp==4,"position"]=df[df$chr_snp==4,"position"]+787151827
df[df$chr_trans==5,"trans_position"]=df[df$chr_trans==5,"trans_position"]+1034146432
df[df$chr_snp==5,"position"]=df[df$chr_snp==5,"position"]+1034146432
df[df$chr_trans==6,"trans_position"]=df[df$chr_trans==6,"trans_position"]+1258048672
df[df$chr_snp==6,"position"]=df[df$chr_snp==6,"position"]+1258048672
df[df$chr_trans==7,"trans_position"]=df[df$chr_trans==7,"trans_position"]+1432081842
df[df$chr_snp==7,"position"]=df[df$chr_snp==7,"position"]+1432081842
df[df$chr_trans==8,"trans_position"]=df[df$chr_trans==8,"trans_position"]+1614463384
df[df$chr_snp==8,"position"]=df[df$chr_snp==8,"position"]+1614463384
df[df$chr_trans==9,"trans_position"]=df[df$chr_trans==9,"trans_position"]+1795586021
df[df$chr_snp==9,"position"]=df[df$chr_snp==9,"position"]+1795586021
df[df$chr_trans==10,"trans_position"]=df[df$chr_trans==10,"trans_position"]+1955355803
df[df$chr_snp==10,"position"]=df[df$chr_snp==10,"position"]+1955355803

ggplot(df)+
  geom_point(aes(x = position/1000000, y = trans_position/1000000),size=0.8)+
  geom_vline(xintercept = 0, color = "#E64B35FF")+
  geom_vline(xintercept = 307041717/1000000, color = "#E64B35FF")+
  geom_vline(xintercept = (307041717+244442276)/1000000, color = "#E64B35FF")+
  geom_vline(xintercept = (307041717+244442276+235667834)/1000000, color = "#E64B35FF")+
  geom_vline(xintercept = (307041717+244442276+235667834+246994605)/1000000, color = "#E64B35FF")+
  geom_vline(xintercept = (307041717+244442276+235667834+246994605+223902240)/1000000, color = "#E64B35FF")+
  geom_vline(xintercept = (307041717+244442276+235667834+246994605+223902240+174033170)/1000000, color = "#E64B35FF")+
  geom_vline(xintercept = (307041717+244442276+235667834+246994605+223902240+174033170+182381542)/1000000, color = "#E64B35FF")+
  geom_vline(xintercept = (307041717+244442276+235667834+246994605+223902240+174033170+182381542+181122637)/1000000, color = "#E64B35FF")+
  geom_vline(xintercept = (307041717+244442276+235667834+246994605+223902240+174033170+182381542+181122637+159769782)/1000000, color="#E64B35FF")+
  geom_vline(xintercept = (307041717+244442276+235667834+246994605+223902240+174033170+182381542+181122637+159769782+150982314)/1000000, color = "#E64B35FF")+
  geom_hline(yintercept = 0, color = "#E64B35FF")+
  geom_hline(yintercept = 307041717/1000000, color = "#E64B35FF")+
  geom_hline(yintercept = (307041717+244442276)/1000000, color = "#E64B35FF")+
  geom_hline(yintercept = (307041717+244442276+235667834)/1000000, color = "#E64B35FF")+
  geom_hline(yintercept = (307041717+244442276+235667834+246994605)/1000000, color = "#E64B35FF")+
  geom_hline(yintercept = (307041717+244442276+235667834+246994605+223902240)/1000000, color = "#E64B35FF")+
  geom_hline(yintercept = (307041717+244442276+235667834+246994605+223902240+174033170)/1000000, color = "#E64B35FF")+
  geom_hline(yintercept = (307041717+244442276+235667834+246994605+223902240+174033170+182381542)/1000000, color = "#E64B35FF")+
  geom_hline(yintercept = (307041717+244442276+235667834+246994605+223902240+174033170+182381542+181122637)/1000000, color = "#E64B35FF")+
  geom_hline(yintercept = (307041717+244442276+235667834+246994605+223902240+174033170+182381542+181122637+159769782)/1000000, color="#E64B35FF")+
  geom_hline(yintercept = (307041717+244442276+235667834+246994605+223902240+174033170+182381542+181122637+159769782+150982314)/1000000, color = "#E64B35FF")+
  theme(plot.title = element_text(size = 25, vjust = 0.5, hjust = 0.5),
        legend.title = element_blank(),
        legend.text = element_text(size = 15),
        legend.position = 'right',
        legend.key.size=unit(0.5,'cm'),
        axis.line=element_line(size = 1,color="black"),###显示x,y???
        #axis.ticks.x=element_blank(), ###取消x轴刻度线
        ##取消边框背景设置 
        panel.background = element_rect(fill = "transparent",colour = NA), 
        panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        plot.background = element_rect(fill = "transparent",colour = NA))
