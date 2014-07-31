

class BinarySearch:
        NOT_FOUND = -1
 
        def binarySearch(self, arr, searchValue, left, right):
                if right < left:
                        return self.NOT_FOUND
 
                mid = int((left + right) / 2)
                if searchValue > arr[mid]:
                        return self.binarySearch(arr, searchValue, mid + 1, right)
                elif searchValue < arr[mid]:
                        return self.binarySearch(arr, searchValue, left, mid - 1)
                else:
                        return mid
 
        def search(self, arr, searchValue):
                left = 0
                right = len(arr) - 1
                return self.binarySearch(arr, searchValue, left, right)
 
	
def convert_line(line):
	a = line.split('\t')
	arr = ["rs"+a[1],a[4]+"/"+a[5],a[0],a[1],"+","orcus","imsut-riken", "urn1","urn2","urn3"]
	arr = arr +a[9:]
	return ' '.join(arr)

def write_header(f):
	f.write("#Settings:\n")
	f.write("#   minimum MAF: 0.00\n")
	f.write("rs# alleles chrom pos strand assembly# center protLSID assayLSID panelLSID NA06985 NA06991 NA06993 NA06994 NA07000 NA07019 NA07022 NA07029 NA07034 NA07048 NA07055 NA07056 NA07345 NA07348 NA07357 NA12264 NA12707 NA12716\n")


def write_result(common_snps,common_snps_raw):
	for key in common_snps.keys():
		if len(common_snps[key]) == 0:
			continue	
		with open("Splitted/hapmap"+key, mode='w') as f_res:
			write_header(f_res)			
			for position in common_snps[key]:
				f_res.write(common_snps_raw[key +"_"+ str(position)] + '\n')


f = open("polar_bear.pooled.snp.txt")
f.readline()
lines = f.readlines()
f.close()
polar_bears = {}
#split our data by scaffold name
#if on same scaffold and position polar and brown bears will have different alleles (i.e. AC AG) algorithm won't take care of this
for line in lines:
	arr = line.split('\t')
	scaffold,position = arr[0],int(arr[1])
	if scaffold not in polar_bears:
		polar_bears[scaffold] = [position]		
	else:
		polar_bears[scaffold].append(position)


isFirst = True
common_snps = {}
common_snps_raw = {}

for key,value in polar_bears.items():
	common_snps[key] = []
bs = BinarySearch()
counter = 0
with open("brown_bear.pooled.snp.txt") as f_brown:
	for line in f_brown:
		counter+=1
		if isFirst:
			isFirst = False
			continue
		if counter%10**6==0:
			print("progress: " + str(counter))		
		arr = line.split('\t')
		scaffold,position = arr[0],int(arr[1])
		if scaffold in polar_bears:
			index = bs.search(polar_bears[scaffold],position)
			if index != -1:
				common_snps[scaffold].append(position)
				common_snps_raw[scaffold +"_" + str(position)] = convert_line(line)
write_result(common_snps,common_snps_raw)
