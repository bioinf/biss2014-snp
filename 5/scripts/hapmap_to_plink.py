

def load_hapmap(filename):
	lines = []
	with open(filename) as f:
		f.readline()
		for line in f:
			a = line.split(' ')
			lines.append(a)
	return lines


def hapmap_to_plink(lines,output):
	with open(output,mode='w') as f:
		for line in lines:
			f.write(' '.join([line[0],])
