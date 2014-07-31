

f = open("polar_bear.pooled.snp.txt")
f.readline()
f_res = open("polar_bear_snp_hapmap.txt", mode='w')
f_res.write("#Settings:\n")
f_res.write("#   minimum MAF: 0.00\n")

f_res.write("rs# alleles chrom pos strand assembly# center protLSID assayLSID panelLSID NA06985 NA06991 NA06993 NA06994 NA07000 NA07019 NA07022 NA07029 NA07034 NA07048 NA07055 NA07056 NA07345 NA07348 NA07357 NA12264 NA12707 NA12716\n")

for i in range(1,2385281): #magic number
	a = f.readline().split("\t")
	if a[0]!="scaffold79":
		break
	line = ["rs"+str(i),a[4]+"/"+a[5],a[0],a[1],"+","orcus","imsut-riken", "urn1","urn2","urn3"]
	line = line +a[9:]
	f_res.write(' '.join(line))
f.close()
f_res.close()

