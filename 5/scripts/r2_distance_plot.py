
import matplotlib.pyplot as plt
import matplotlib.cbook as cbook
import numpy as np
import math

def parseLD(filename):
	x,y = [],[]
	with open(filename) as f:
		f.readline()
		for line in f:
			a = line.split('\t')
			b,c = float(a[7]),float(a[4])
			if b<500000:
				x.append(b)
				y.append(c)
	return x,y


x,y=parseLD("scaffold224_ld_mixed.txt")
r2 = [[] for i in xrange(50)]
for i in xrange(0,len(y)):
	r2[int(math.floor(x[i]/10000))].append(y[i])
r2averages = []
for r in r2:
	if len(r)!=0:
		r2averages.append(sum(r)/len(r))
	else:
		r2averages.append(0)

plt.plot([10000*i for i in xrange(50)],r2averages,'ro')

#fig.tight_layout()

plt.show()
