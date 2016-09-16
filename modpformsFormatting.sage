######################################################
######################################################
######################################################
#
# modpmodformsFormatting.sage
# Formatting the output for the LMFDBD
# Anna Medvedovsky
#
#
#[13, 1, 1, 0, "", [12, "1.12.1.a", "x", "(13)"], "13.1.1", [[1, 1]], 200, ["0", "1", "2", "5", "10", "7", "10", "0", "6", "3", "1", "0", "11", "8", "0", "9", "7", "4", "6", "3", "5", "0", "0", "11", "4", "2", "3", "9", "0", "1", "5", "12", "11", "0", "8", "0", "4", "3", "6", "1", "3", "6", "0", "11", "0", "8", "9", "1", "9", "11", "4", "7", "2", "10", "5", "0", "0", "2", "2", "7", "12", "3", "11", "0", "12", "4", "0", "9", "1", "3", "0", "10", "5", "6", "6", "10", "4", "0", "2", "4", "10", "5", "12", "9", "0", "2", "9", "5", "0", "8", "3", "0", "6", "8", "2", "8", "3", "7", "9", "0", "7", "12", "1", "3", "9", "0", "7", "2", "12", "4", "0", "2", "0", "7", "4", "12", "10", "11", "1", "0", "2", "7", "6", "4", "3", "10", "0", "8", "12", "3", "8", "5", "0", "0", "5", "11", "11", "7", "6", "1", "0", "5", "7", "0", "8", "7", "12", "3", "4", "10", "7", "8", "5", "12", "0", "6", "10", "0", "8", "11", "12", "0", "10", "8", "8", "0", "5", "3", "0", "12", "4", "9", "6", "5", "10", "0", "0", "9", "3", "0", "2", "11", "0", "2", "1", "8", "3", "0", "10", "0", "3", "2", "8", "6", "1", "7", "6", "10", "0", "7"], 0, 12, [[26,""],[16,""],[30,""],[44,""],[58,""],[72,""],[86,""],[100,""],[114,""],[128,""],[142,""],[156,""]]]

#def dubquote(stringy):
	# input: string
	# output: same string enclosed in double quotes
#	return '\"' + stringy + '\"'

def FindReplace(oldfile, newfile, thingtofind, thingtoreplace):
	#
	# runs find and replace on a whole file
	#
	fold = open(oldfile, 'r')
	fnew = open(newfile, 'w')
	for line in fold:
		fnew.write(line.replace(thingtofind, thingtoreplace))
	fold.close()
	fnew.close()


def labelize(listy):
	# input: list of integers, say [a, b, c]
	# output: string 'a.b.c'
	stringy = ''
	for item in listy:
		stringy = stringy + str(item) + '.'
	stringy = stringy[:-1]
	return stringy

def SanniLine(qseries, N, k, p):
	mod = p
	deg = qseries.parent().base_ring().degree()
	minlevel = N # This will be true for forms that we're allowed to include!
	wtgrade = (k % (p - 1))
	reducibilitydata = "" # NOT IMPLEMENTED!
	liftdata = [k, labelize([p, N, 1]), '', ''] # NOT IMPLEMENTED
	dirchar = labelize([p, N, 1])
	atkinlehner = "" # NOT IMPLEMENTED!
	prec = qseries.prec()
	coeffs = [(str(item)) for item in qseries]
	ord = ZZ((qseries[p] != 0))
	thetacy = thetacycle(p, k, ord, includek = False)
	minwtinthetacy = min(thetacy + [k])
	thetacy = [[item, labelize([N, item, 1])] for item in thetacy]
	return [mod, deg, minlevel, wtgrade,reducibilitydata, liftdata, dirchar, atkinlehner, prec, coeffs, ord, minwtinthetacy,thetacy]


def parsehelperfileline(line, conwayvary = 'x'):
	#
	# input line in form [N, k, p, d, [Fourier coeffs]] coming from helperfile
	#
	#
	v = line.split('[')
	w = v[1].split(', ')
	w.pop()
	N, k, p, d = [ZZ(item) for item in w]
	w = v[2].split(']')[0].split(', ')
	FF = FiniteField(p^d, conwayvary)
	coefflist = [FF(item) for item in w]
	return N, k, p, d, coefflist


def isformold(N, k, p, qseries, helperfile, conwayvary = 'x'):
	#
	# Trying to determie if qseries (eigenform mod p of level N, weight k)
	# is old at N coming from any of the already-recorded forms of lower level
	# in file helperfile. 
	#
	# Function looks through every already-recorded form in helperfile, 
	# finds all of its promotions to the current level, and 
	# compares to current form. Comparisons are only at prime Fourier coeffs -- 
	# for eigenforms this is the same as considering all the Fourier coeffs -- 
	# so we only consider primes up to the sturm bound.  
	# (Loosely based on outline of algorithm presented in Samuele Anni's thesis.)
	#
	# conwayvary is the variable that helperfile uses for the conway parameter
	# if the forms recorded there are in an extension of F_p. 
	#
	# If form is old, returns lowest level. If form is not old, returns False.
	#
	#
	sturmy = sturm_bound(N, k) + 1
	LL = getprimes(sturmy)
	v = qseries.padded_list()
	f = open(helperfile, 'r')
	for line in f:
		Nline, kline, pline, dline, coeffsline = parsehelperfileline(line, conwayvary)
		if kline == k and Nline < N and Nline.divides(N):
		# We're looking at a form of the same weight and lower level as qseries.	
			M = ZZ(N/Nline) 
			# This is the "promotion" level.
			for ell in LL: 
				# checking at each prime lower than the sturm bound
				if gcd(ell, M) == 1 and coeffsline[ell] != v[ell]:
					break 
				# Fourier coeffs at every nonpromoted prime must agree. 
				vally = Nline.valuation(ell)
				if vally == 0:
					#
					# If low-level form g has no ell in the level, and
					# ell^e || M, then v[ell] must be a root of
					# X^(e-1)*(X^2 - a_ell(g) X + ell^(k-1))
					# So either e = 1 and v[ell] is root, or
					# e > 1 and v[ell] is root or v[ell] = 0. 
					#
					polyval = v[ell]^2 - coeffsline[ell]*v[ell] + ell^(kline - 1)
					if not(polyval == 0) and not(v[ell] == 0 and (ell^2).divides(M)):
						break 
				elif vally > 1: 
					#
					# If low-level form was new at ell 
					# so its Fourier coeff at ell = \pm ell^(k/2 + 2)) 
					# then our v[ell] must be same or 0
					#
					# If low-level form was new at ell^2
					# then its Fourier coeff at ell = 0
					# and v[ell] must be 0 as well. 
					#
					if (v[ell] != 0) and not(vally == 1 and v[ell] == coeffsline[ell]):
						break
			else: # i.e., if the for-loop completed without breaking
				return Nline
		else: # i.e, basic data doesn't match up
			continue # go on to the next line in helperfile
	return False


def isforminHasseim(N, k, p, qseries, helperfile, conwayvary = 'x'):
	#
	# Checks ONLY if the qseries is already in helperfile with weight k - (p - 1).
	#
	klow = k - (p - 1)
	sturmy = sturm_bound(N, k) + 1
	v = qseries.padded_list()
	f = open(helperfile, 'r')
	for line in f:
		Nline, kline, pline, dline, coeffsline = parsehelperfileline(line, conwayvary)
		if p == pline and N == Nline and klow == kline:
			for i in range(sturmy): 
				if v[i] != coeffsline[i]: 
					break # quit looking at this line -- go on to the next one
				else: 
					continue # i.e., go on to the next coefficient
			else: # i.e., no break statement was encountered!
				return True
		else: #i.e., the basic data N, k, p already doesn't match up
			continue # i.e., go on to the next line in helperfile
	return False #if you made it here, no forms match up 


def ModpLMFDBout(p, levelrange = (1, 50), prec = 50, conwayvary = 'x'):
	#
	# Output mod-p q-expansions of forms of weight 2 <= k <= p + 1 of given level
	# as formatted list as per github README
	#
	directory = "/Users/Anna/Dropbox/HOME/Annastuff/AnnaCurrentWork/LMFDB/modpformsdata/"
	prec = max(p + 1, prec) # need to tell if form is ordinary!
	filename = "Mod" + str(p) + "forms_LowkN" + str(levelrange[0]) + "to" + str(levelrange[1]) + "Prec" + str(prec)
#	print filename
	tempy = directory + "temp" # this the main file but with single quotes
	helperfile = directory + filename + "_helperfile" # this is the easy-to-read file for checking whether a form deserves to be included!
	discardfile = directory + filename + "_discardfile" # this keeps track of the forms that didn't get in and why
	f = clearfile(tempy)
	f = clearfile(helperfile)
	f = clearfile(discardfile)
	levelrange = [N for N in range(levelrange[0], levelrange[1] + 1) if N % p != 0]
	for N in levelrange:
		for k in range(2, p + 3, 2):
			#
			# for Gamma0, range is 2 <= k <= p + 1, 
			# except when p = 2, when range is k in [2, 4] 
			#
			print "------------------------------------------"
			print "N =", N, "k =", k, "mod", p
			if k < 3:
				prec = max(prec, sturm_bound(N, k + (p-1)))
				# if weight is very, very low, Hasse(form) is still low weight,
				# so we'll have to check for that and will need the sturm
				# bound of the higher low weight.
			v = modpeigenforms(N = N, k = k, p = p, PREC = prec, verbose = False)
			for qseries in v:
				if k == p + 1 and isforminHasseim(N, k, p, qseries, helperfile, conwayvary):
				# This means the form has filtration 2, and is already in database at that weight. 
					print "Skipping form from weight 2."#, [qseries]
					writethingtofile(discardfile, ["Hasse from k = 2", N, k, qseries])
					continue 
					# i.e., continue on with the next qseries in v
				Nlow = isformold(N, k, p, qseries, helperfile, conwayvary)
				if Nlow:
					print "Skipping form from level", Nlow, [qseries]
					writethingtofile(discardfile, ["Old from k = "+str(Nlow), N, k, qseries])
				else:
					Sanni = SanniLine(qseries, N, k, p)
					print [qseries]
					writethingtofile(tempy, Sanni)
					writenewlinetofile(tempy)
					writenewlinetofile(tempy)
					writethingtofile(helperfile, [N, k, p, Sanni[1], qseries.padded_list()])
					writenewlinetofile(helperfile)
	forsamuele = directory + filename
	FindReplace(tempy, forsamuele, "\'", "\"")


