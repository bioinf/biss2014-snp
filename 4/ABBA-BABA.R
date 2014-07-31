# ABBA-BABA test for polar-brown-ancient bears

rm(list = ls(all.names = TRUE))
getwd()

# read data
SNP_brown_data<-read.table("../../school/proj/brown_bear.pooled.snp.txt", header = T, stringsAsFactors = FALSE)
SNP_polar_data<-read.table("../../school/proj/polar_bear.pooled.snp.txt", header = T, stringsAsFactors = FALSE)

# subset SNP for each scaffold in the same position in both(polar-brown) 
scaffolds<-unique(SNP_polar_data$chromo) # vector of scaffolds names
list_SNP_brown_merged<-list()
list_SNP_polar_merged<-list()
scaffolds_1<-scaffolds[1:3]
for(l in scaffolds_1){              
  i<-which(SNP_brown_data$chromo==l)    
  j<-which(SNP_polar_data$chromo==l)
  a<-SNP_brown_data[i,]$position
  b<-SNP_polar_data[j,]$position
  coord<-match(a,b)
  uni_coord_1<-which(coord!="NA")
  print(length(uni_coord_1))
  list_SNP_brown_merged[[l]]<-SNP_brown_data[uni_coord_1,]
  coord<-match(b,a)
  uni_coord_2<-which(coord!="NA")
  list_SNP_polar_merged[[l]]<-SNP_polar_data[uni_coord_2,]
  print(length(uni_coord_2))
  int_brown<-as.numeric(as.factor(list_SNP_brown_merged[[l]]$anc))
  int_polar<-as.numeric(as.factor(list_SNP_polar_merged[[l]]$anc))
  d<-which((int_brown-int_polar)==0)
  list_SNP_brown_merged[[l]]<-list_SNP_brown_merged[[l]][d,]
  list_SNP_polar_merged[[l]]<-list_SNP_polar_merged[[l]][d,]
  print(nrow(list_SNP_brown_merged[[l]]))
}


as.numeric(as.factor(list_SNP_brown_merged[[1]]$ABC01))
list_SNP_brown_merged[[1]]$ABC01
string<-c("balala")
x<-strsplit(string, "")
for(i in 1:6){
  x<- t(matrix(unlist(strsplit(as.vector(list_SNP_brown_merged[[1]][,9+i]), "")), 
           ncol=length(list_SNP_brown_merged[[1]][,9+i]), nrow=2))
  if (i==1){
    matr<-x
  }
  else {
    matr<-cbind(matr,x)
  }
}

val<-as.matrix(table(matr[3,]))








Slist_SNP_brown_merged[[1]]$anc
list_SNP_polar_merged[[1]]$anc
int_brown<-as.numeric(as.factor(list_SNP_brown_merged[[1]]$ref))
int_polar<-as.numeric(as.factor(list_SNP_brown_merged[[1]]$major))
int_brown-int_polar
d<-which((int_brown-int_polar)==0)
length(d)
list_SNP_brown_merged[[1]]<-list_SNP_brown_merged[[1]][d,]

int_brown<-as.numeric(as.factor(list_SNP_brown_merged[[1]]$ref))
int_polar<-as.numeric(as.factor(list_SNP_polar_merged[[1]]$ref))
int_brown-int_polar
d<-which((int_brown-int_polar)!=0)
length(d)






l="scaffold79"
i=0
j=0
list_ident<-list()
i<-which(SNP_brown_data$chromo==l)
j<-which(SNP_polar_data$chromo==l)
a<-SNP_brown_data[i,]$position
b<-SNP_polar_data[j,]$position
coord<-match(a,b)
k<-a[coord]
uni_coord_1<-unique(which(coord!="NA"))
SNP_brown_merge<-SNP_brown_data[uni_coord,]
coord<-match(b,a)
uni_coord_2<-unique(which(coord!="NA"))
list_SNP_polar_merged[[l]]<-SNP_polar_data[uni_coord_2,]
print(length(uni_coord_2))
