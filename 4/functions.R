# functions for ABBA-BABA.R
# split alleles
subset_snp_data<-function(list_data, col_min, col_max){
  matr<-list_data$anc
  max<-col_max-col_min+1
  for(i in 1:(col_max-col_min+1)){
    x<- t(matrix(unlist(strsplit(as.vector(list_data[,col_min-1+i]), "")), 
                 ncol=length(list_data[,col_min-1+i]), nrow=2))
    colnames(x)<-c("All_1", "All_2")
    matr<-cbind(matr,x)
  }
  colnames(matr)[1]<-c("anc")
  return(matr)
}
# count frequences
count_freq_SNP<-function(matr){
  l_m<-nrow(matr)
  c_m<-ncol(matr)
  frequences<-matrix(0,l_m,2)
  colnames(frequences)<-c("A", "B")
  for (i in 1:l_m) {
    value_count<-which(matr[i,2:c_m]==matr[i,1])
    frequences[i,1]<-length(value_count)
    frequences[i,2]<-(ncol(matr)-1-frequences[i,1])
  }
  frequences<-frequences/rowSums(frequences)
  return(frequences)
}

# subset SNP 
count_d <-function(list_SNP_brown_merged, list_SNP_polar_merged){
  matr_1<-subset_snp_data(list_SNP_brown_merged, 10,15)
  matr_2<-subset_snp_data(list_SNP_brown_merged, 16,19)
  matr_3<-subset_snp_data(list_SNP_polar_merged, 10, 27)
  pop1<-count_freq_SNP(matr_1)
  pop2<-count_freq_SNP(matr_2)
  pop3<-count_freq_SNP(matr_3)
  numerator<-0
  denominator<-0
  for (i in 1:nrow(matr_1)){
    numerator<-((pop1[i,1]*pop2[i,2]*pop3[i,2]) - (pop1[i,2]*pop2[i,1]*pop3[i,2]) + numerator)
    denominator<-((pop1[i,1]*pop2[i,2]*pop3[i,2]) + (pop1[i,2]*pop2[i,1]*pop3[i,2]) + denominator)
  }
  d <- numerator / denominator
  return(d)
}
