# ABBA-BABA test for polar-brown-ancient bears

rm(list = ls(all.names = TRUE))
getwd()
setwd("../../school")
# include functions
source("functions.R")

# read data
SNP_brown_data<-read.table("../../school/proj/brown_bear.pooled.snp.txt", header = T, stringsAsFactors = FALSE)
SNP_polar_data<-read.table("../../school/proj/polar_bear.pooled.snp.txt", header = T, stringsAsFactors = FALSE)

# subset SNP for each scaffold in the same position in both(polar-brown) and then subset SNP for which anc population match
scaffolds<-unique(SNP_polar_data$chromo) # vector of scaffolds names
list_SNP_brown_merged<-list()
list_SNP_polar_merged<-list()
scaffolds_1<-scaffolds[1:3]
scaff_lenght<-length(scaffolds)
for(l in 1:scaff_lenght){              
  i<-which(SNP_brown_data$chromo==scaffolds[l])    
  j<-which(SNP_polar_data$chromo==scaffolds[l])
  print(scaffolds[l])
  a<-SNP_brown_data[i,]$position
  b<-SNP_polar_data[j,]$position
  coord<-match(a,b)                   
  uni_coord_1<-which(coord!="NA")
  #print(length(uni_coord_1))
  list_SNP_brown_merged[[l]]<-SNP_brown_data[uni_coord_1+i[1]-1,]
  coord<-match(b,a)
  uni_coord_2<-which(coord!="NA")
  list_SNP_polar_merged[[l]]<-SNP_polar_data[uni_coord_2+j[1]-1,]
  #print(length(uni_coord_2))
  int_brown<-as.numeric(as.factor(list_SNP_brown_merged[[l]]$anc))
  int_polar<-as.numeric(as.factor(list_SNP_polar_merged[[l]]$anc))
  d<-which((int_brown-int_polar)==0)
  length(d)
  list_SNP_brown_merged[[l]]<-list_SNP_brown_merged[[l]][d,]
  list_SNP_polar_merged[[l]]<-list_SNP_polar_merged[[l]][d,]
  print(nrow(list_SNP_brown_merged[[l]]))
  print(l)
}

# count vector of D for each scaffold
vector_d<-vector()
for (i in 1:215){
  vector_d[i]<-count_d(list_SNP_brown_merged[[i]], list_SNP_polar_merged[[i]])
  print(i)
}
names(vector_d)<-scaffolds
vector_d
length(which(vector_d>0))


