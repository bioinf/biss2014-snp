# ABBA-BABA test for polar-brown-ancient bears

rm(list = ls(all.names = TRUE))
getwd()

# read data
SNP_brown_data<-as.matrix(read.table("../dataset/brown_bear.pooled.snp.txt", header = T, stringsAsFactors = FALSE))
SNP_polar_data<-as.matrix(read.table("../dataset/polar_bear.pooled.snp.txt", header = T, stringsAsFactors = FALSE))

scaffolds<-unique(SNP_polar_data[,"chromo"]) # massive scaff

count_p<-function (SNP_brown_data, SNP_polar_data, l) {

matrix_SNP_brown_merged<-matrix(NA,0,19)
matrix_SNP_polar_merged<-matrix(NA,0,27)

{              #for each scaff
  matrix_SNP_brown_merged<-matrix(NA,0,19)
  matrix_SNP_polar_merged<-matrix(NA,0,27)
  
  
  pos_brown<-as.factor(SNP_brown_data[which(SNP_brown_data[,"chromo"]==l),"position"])
  pos_polar<-as.factor(SNP_polar_data[which(SNP_polar_data[,"chromo"]==l),"position"])
  
  uni_coord_1<-which(match(pos_brown, pos_polar) !="NA")
  uni_coord_2<-which(match(pos_polar, pos_brown) !="NA")
   
  int_brown<-as.numeric(as.factor(SNP_brown_data[which(SNP_brown_data[,"chromo"]==l),][uni_coord_1, "anc"]))
  int_polar<-as.numeric(as.factor(SNP_polar_data[which(SNP_polar_data[,"chromo"]==l),][uni_coord_2, "anc"]))
  d<-which((int_brown-int_polar)==0)
  
  matrix_SNP_brown_merged<-rbind(matrix_SNP_brown_merged,SNP_brown_data[which(SNP_brown_data[,"chromo"]==l),][uni_coord_1,][d,])
  matrix_SNP_polar_merged<-rbind(matrix_SNP_polar_merged,SNP_polar_data[which(SNP_polar_data[,"chromo"]==l),][uni_coord_2,][d,])
}

pop_nucl<-function(matrix_snp, fp, lp){
  x<-t(matrix(unlist(strsplit(matrix_snp[1,fp:lp],""))))
  for (i in 2:nrow(matrix_snp))
  {
    x<-rbind(x, t(matrix(unlist(strsplit(matrix_snp[i,fp:lp],"")))))
  }  
  return(x)
}  

nuc_brown_ABC<-pop_nucl(matrix_SNP_brown_merged,10,15)
nuc_brown_other<-pop_nucl(matrix_SNP_brown_merged,16,19)
nuc_polar_all<-pop_nucl(matrix_SNP_polar_merged,10,27)

count_alleles<-function(population, anc){
  
  count<-matrix(NA,nrow(population), 3)
  
  for (i in 1:nrow(population))
  {
    count[i,1]<-length(which (population[i,] == anc[i]))
    count[i,2]<-(ncol(population)-count[i,1])
    count[i,3]<-(count[i,2]/(count[i,1]+count[i,2]))
  }
  return(count)
}

count_brown_abc<-count_alleles(brown_ABC, matrix_SNP_brown_merged[,"anc"])
count_brown_others<-count_alleles(brown_other, matrix_SNP_brown_merged[,"anc"])
count_polar_all<-count_alleles(polar_all, matrix_SNP_brown_merged[,"anc"])

m<-cbind(count_brown_abc[,3], count_brown_others[,3], count_polar_all[,3])
colnames(m)<-c("brown_abc", "brown_others", "polar_all")
return (m)
}

out = count_p(SNP_brown_data, SNP_polar_data, "scaffold232")
