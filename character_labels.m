p:=5;
e:=2;
ell:=7;
n:=EulerPhi(p^e);
Q<zeta>:=CyclotomicField(n);
M:=MaximalOrder(Q);
R<x>:=PolynomialRing(Rationals());

U,mU:=UnitGroup(Integers(p^e));
log1:=func<x|Eltseq(Inverse(mU)(x))[1]>;
//Conrey character for p^e
conr:=func<n,m|zeta^(log1(n)*log1(m))>;

//George's condition
assert not(n mod ell eq 0);

rfunc:=func<n,ell|Minimum([r: r in Divisors(EulerPhi(n)) | (((ell^r-1) mod n) eq 0)])>;

alpha:=GF(ell^rfunc(n,ell)).1;
zetaell:=alpha^(Integers()!((ell^rfunc(n,ell)-1)/n));

print MinimalPolynomial(zetaell);


