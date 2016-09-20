GetSturmBound:=function(N,k,extra)
	return Ceiling(k*Index(Gamma0(N))/12)+extra;
end function;

/*function FiniteDirichletCharsWrong(n,l)
//compute the group size
n1:=Integers()!(n/l^Valuation(n,l));
val2:=Valuation(n1,2);
n0:=Integers()!(n1/2^val2);

gpord:=1;
R<x>:=PolynomialRing(GF(l));
if (val2 eq 0) then
	gpord:=EulerPhi(n0);
	f:=x^(gpord)-1;
	fieldext:=SplittingField(f);
end if;
if (val2 eq 1) or (val2 eq 2) then
	gpord:=2*EulerPhi(n0);
	f:=x^(gpord)-1;
	fieldext:=SplittingField(f);
end if;
if (val2 ge 3) then
	gpord:=2^(val2-1)*EulerPhi(n0);
	f:=x^(gpord)-1;
	fieldext:=SplittingField(f);
end if;
G:=DirichletGroup(n,fieldext);
return G,fieldext;
end function;*/

function FiniteDirichletChars(n,l)
//compute the group size
UG:=UnitGroup(Integers(n));
gpord:=#UG;
fact:=Factorization(gpord);
primes:=[x[1]: x in fact];
primes0:=[p: p in primes | not (p eq l)];
prims:=SequenceToSet(PrimaryAbelianInvariants(UG));
maxprims:=[Maximum([x: x in prims|Valuation(x,p) gt 0]): p in primes0];
R<x>:=PolynomialRing(GF(l));
f:=&*([x^(el)-1: el in maxprims] cat [x]);
fieldext:=SplittingField(f);
G:=DirichletGroup(n,fieldext);
return G,fieldext;
end function;

function PrimitiveDirichletChars(n,l)
G:=FiniteDirichletChars(n,l);
Prim:=[x: x in Elements(G)| IsPrimitive(x)];
return Prim;
end function;


/*fields:=[**];
badcases:=[**];
for n in [2..100] do
for k in [1..20] do
G,F:=FiniteDirichletChars(n,NthPrime(k));
fields:=fields cat [*<F,G,n,NthPrime(k)>*];
if not(ExistsConwayPolynomial(Characteristic(F),Degree(F))) then
badcases:=badcases cat [*<F,G,n,NthPrime(k)>*];
end if;
end for;
end for;*/


function IsReducible(n,k,l,coeffs,extra)
if  coeffs[l] eq 0 then
	//this is an irreducible representation
	return false;
else
	//we want to find characters that define the semisimplification
	BSturm:=GetSturmBound(n,k,extra);
	pprimes0:=[p: p in PrimesUpTo(BSturm)|not (p eq l)];
	//print pprimes0;
	charpairs:=[*<chi,a>: chi in PrimitiveDirichletChars(n,l), a in [0..(k-1)]*];
	goodpairs:=[**];
	for chipair in charpairs do
		chi,a:=Explode(chipair);
		//print [chi(i): i in [1..10]];
		b:=(k-1)-a;
		//print [chi(p)*p^a+(chi^(-1))(p)*p^b-coeffs[p]: p in pprimes0];
		
		is_reducible:=true;
		for p in pprimes0 do
		
		cp:=chi(p)*p^a+(chi^(-1))(p)*p^b;
		//print cp-coeffs[p];
	
		if not (cp eq coeffs[p]) then
			is_reducible:=false;
			break;
		end if;
		end for;
		
		if is_reducible then
			goodpairs:=goodpairs cat [*<chi,chi^(-1),a,b>*];
		end if;
	end for;
	
	if #goodpairs gt 0 then
	return true, goodpairs;
	end if;
	//checking for trivial character and cyclotomic
	
	//find an auxiliary prime for twisting
	
	q:=Minimum([x: x in [NthPrime(k): k in [2..40]] | not((l*n mod x) eq 0)]);
	pprimes:=[p: p in PrimesUpTo(BSturm)| not (p eq l) and not (p eq q)];
	
	if (k eq l) or (l eq 2) or (k eq 2) or (k eq (l-1)) or (k*q*(q+1) le k+l+1) then
	BSturmmod:=GetSturmBound(n*q^2,k,extra);
	//we don't have enough coefficients precomputed so we send a further warning to check congruence up to the new bound
	
	//a+b=k-1 and a<=b
	chars:=[a: a in [0..Floor((k-1)/2)]];
	goodpairs:=[];
	for chi in chars do
		a:=chi;
		b:=(k-1)-a;
		is_reducible:=true;
		for p in pprimes do
		
		if (n mod p) eq 0 then
			cp:=0;
		else
			cp:=p^a+p^b;
		end if;
	
		if not (cp eq coeffs[p]) then
			is_reducible:=false;
			break;
		end if;
		end for;
		
		if is_reducible then
			goodpairs:=goodpairs cat [<a,b,BSturmmod>];
			print "Sturm bound increased (type 1), please check!";
		end if;
	
	end for;
	
	if #goodpairs gt 0 then
		return true, goodpairs;
	end if;
	else
	BSturmmod:=GetSturmBound(n,k+l+1,extra);
	//we don't have enough coefficients precomputed so we send a further warning to check congruence up to the new bound
	
	//a+b=k-1 and a<=b
	chars:=[a: a in [0..Floor((k-1)/2)]];
	goodpairs:=[];
	for chi in chars do
		a:=chi;
		b:=(k-1)-a;
		is_reducible:=true;
		for p in pprimes do
		
		if (n mod p) eq 0 then
			cp:=0;
		else
			cp:=p^a+p^b;
		end if;
	
		if not (cp eq coeffs[p]) then
			is_almost_reducible:=false;
			break;
		end if;
		end for;
		
		if is_reducible then
			goodpairs:=goodpairs cat [<a,b,BSturmmod>];
			print "Sturm bound increased (type 2), please check!";
		end if;
	
	end for;
	
	if #goodpairs gt 0 then
		return true, goodpairs;
	end if;
	
	end if;
	
end if;
return false;
end function;

/*k:=12;
N:=1;
ell:=691;
M:=ModularForms(Gamma0(N),k);
E:=EisensteinSeries(M)[1];
New:=Newforms(CuspForms(Gamma0(N),k))[1][1];
f:=New;
F:=GF(ell);
out1,out2:=IsReducible(N,k,ell,[F!Coefficient(f,k): k in [1..1000]],50);*/

/*k:=2;
N:=109;
ell:=3;
M:=ModularForms(Gamma0(N),k);
Eis:=EisensteinSeries(M);
New:=Newforms(CuspForms(Gamma0(N),k))[3][1];
f:=New;
K:=FieldOfFractions(BaseRing(New));
M:=MaximalOrder(K);
Pr:=Factorization(ell*M)[1][1];
kk,mkk:=ResidueClassField(Pr);

F:=GF(ell^Degree(kk));
//isom:=Isomorphism(k,F);

out1,out2:=IsReducible(N,k,ell,[mkk(Coefficient(f,k)): k in [1..1000]],50);*/

/*k:=12;
N:=1;
ell:=7;
M:=ModularForms(Gamma0(N),k);
E:=EisensteinSeries(M)[1];
New:=Newforms(CuspForms(Gamma0(N),k))[1][1];
f:=New;
F:=GF(ell);
assert not(IsReducible(N,k,ell,[F!Coefficient(f,k): k in [1..1000]],50));*/


N:=11*3^2;
Prim:=PrimitiveDirichletChars(N,5);
chi:=Prim[2];
a:=1;
b:=2;
k:=a+b+1;
ell:=5;
//this is wrong for non-prime coefficients
tups:=[chi(n)*n^(a)+(chi^(-1))(n)*n^b: n in [1..500]];
tups[5]:=1;
IsReducible(N,k,ell,tups,50);

