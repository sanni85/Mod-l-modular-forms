#
# author: Anna Medvedovsky
#

def thetacycle(p, k, ord, includek = True, errorchecking = False):
	#
	# Uses Edixhoven's algorithm to output a theta cycle for a form, ordinary or not ("ord") 
	# of weight k modulo a prime p, where 1 <= k <= p + 1.
	#
	# includek = True: "cycle" starts with k
	# includek = False: cycle starts with weight of form after applying theta once. last entry of cycle is k if and only if form is nonordinary
	#
	# errorchecking: includes very basic checks used while coding
	#
	if k < 1 or k > p + 1: 
		print "Only works for small weights."
		return
	if includek: 
		v = [[k]]
	else: 
		v = []
	step = p + 1
	if ord:
		if k == 1 or k == p:
			for i in range(1, p): 
				nextk = 1 + i*step
				v = v + [nextk]
		elif k == p + 1:
			for i in range(1, p):
				nextk = k + i*step
				v = v + [nextk]
		else:
			kprime = p + 1 - k
			for i in range(1, p - k + 1):
				nextk = k + i*step
				v = v + [nextk]
			for i in range(1, k):
				nextk = kprime + i*step
				v = v + [nextk]
	else: 
		if k == 1: 
			for i in range(1, p): 
				nextk = k + i*step
				v = v + [nextk]
		elif k == 2:
			for i in range(1, p - 1): 
				nextk = k + i*step
				v = v + [nextk]
			v = v + [2]
		elif k == p:
			for i in range(p-2):
				nextk = 3 + i*step
				v = v + [nextk]
			v = v + [p]
		elif k == p + 1:
			print "This should not occur."
		else:
			k1 = p + 3 - k
			for i in range(1, p - k + 1):
				nextk = k + i*step
				v = v + [nextk]
			if k != k1: 
				for i in range(0, k-2): 
					nextk = k1 + i*step
					v = v + [nextk]
			v = v + [k]
	if errorchecking: 
		if len(v)-1 != p -1 and k != (p+3)/2:
			print "Length emergency!", len(v) -1
		for i in range(1, len(v)-1):
			if v[i + 1] < v[i] and v[i] % p != 0:
				print "EMEREGENCY at (p, k, i) =", (p, k, i)
			if (v[i + 1] - v[i]) % (p-1) != 2:
				print "EMEREGENCY at (p, k, i) =", (p, k, i)
		if v[-1] > v[1] and v[-1] % p != 0: 
			print "EMEREGENCY at (p, k, i) =", (p, k, i)
	return v
