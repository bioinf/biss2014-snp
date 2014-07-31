def convert_line(line):
	a = line.split('\t')
	arr = ["rs"+a[1],a[4]+"/"+a[5],a[0],a[1],"+","orcus","imsut-riken", "urn1","urn2","urn3"]
	arr = arr +a[9:]
	return ' '.join(arr)

def write_header(f):
	f.write("#Settings:\n")
	f.write("#   minimum MAF: 0.00\n")
	f.write("rs# alleles chrom pos strand assembly# center protLSID assayLSID panelLSID NA06985 NA06991 NA06993 NA06994 NA07000 NA07019 NA07022 NA07029 NA07034 NA07048 NA07055 NA07056 NA07345 NA07348 NA07357 NA12264 NA12707 NA12716\n")


oldscaffold = "scaffold79"
lines = []
with open("brown_bear.pooled.snp.txt") as f:
	f.readline()	
	for line in f:
		arr = line.split('\t')
		newscaffold = arr[0]
		if newscaffold != oldscaffold:
			with open("Splitted_polar/hapmap"+oldscaffold, mode='w') as f_res:
				write_header(f_res)
				for old_line in lines:
					f_res.write(convert_line(old_line) +'\n')
			lines.clear()
			oldscaffold = newscaffold
		else:
			lines.append(line)
