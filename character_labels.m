//***************
//auxiliary functions

//compute discrete logarithm function with respect to the lowest (Z/p^e)* generator
function DiscreteLog(p,e)
  U,mU:=UnitGroup(Integers(p^e));
  log1:=func<x|Eltseq(Inverse(mU)(x))[1]>;
  return log1;
end function;


//m in the range {0,1}, 0|--> 1, 1|-->-1
signhelp:=func<m|(-1)^m>;


//***************
//characteristic 0 Conrey characters
//general case of zetaell
function zeta0(n)
  if (n eq 1) then
    return Rationals()!1;
  end if;
  
  if (n eq 2) then
    return Rationals()!(-1);
  end if;
  
  if (n ge 3) then
    _<zeta>:=CyclotomicField(n);
    return zeta;
  end if;
end function;

//generate char 0 Conrey character for odd prime power level
function CharOddPow0(p,e)
  assert not (p mod 2 eq 0);
  
  log1:=DiscreteLog(p,e);
  zet:=zeta0(EulerPhi(p^e));
  
  char1:=func<m,n|zet^(log1(m)*log1(n))>;
  
  return char1;
end function;

//mod ell Conrey character for 2-power level
function CharEvenPow0(e)
 if e eq 1 then
  char1:=func<m,n|1>;
 end if;
 
 if (e eq 2) then
  char1:=function(m,n)
    if m eq 1 then
      return 1;
    else
      return (-1)^(Integers()!((n-1)/2));
    end if;
  end function;
 end if;
 
 //we use the generators for the multiplicative group (Z/2^e)* provided by MAGMA (which is -1 and 5)
 if (e ge 3) then
  U,mU:=UnitGroup(Integers(2^e));
  inv:=Inverse(mU);
  zet:=zeta0(2^(e-2));
  
  char1:=function(m,n)
  ae,a5:=Explode(Eltseq(inv(Integers(2^e)!m)));
  ae:=signhelp(ae);
  
  be,b5:=Explode(Eltseq(inv(Integers(2^e)!n)));
  be:=signhelp(be);
  
  value:=(zet^a5)^b5;
  
  if (ae eq be) and (ae eq -1) then
    value:=-value;
  end if;
  
  return value;
  end function;
 end if;
 
 return char1;
end function;


//full level Dirichlet character using Conrey notation in char 0
function ConrCharEll0(N)
  fact:=Factorization(Abs(N));
  
  if (fact[1][1] eq 2) then
    char2pow:=CharEvenPow0(fact[1][2]);
    
    charoddpows:=[* CharOddPow0(fact[i][1],fact[i][2]): i in [2..#fact] *];
    chars:=[*char2pow*] cat charoddpows;
    
    charfun:=function(m,n)
      if (GCD(m,N) gt 1) or (GCD(n,N) gt 1) then
	return Rationals()!0;
      else
	return &*[char(m,n): char in chars];
      end if;
    end function;
    
    return charfun;
  else
    charoddpows:=[* CharOddPow0(fact[i][1],fact[i][2]): i in [1..#fact] *];
    chars:=charoddpows;
    
    charfun:=function(m,n)
      if (GCD(m,N) gt 1) or (GCD(n,N) gt 1) then
	return Rationals()!0;
      else
	return &*[char(m,n): char in chars];
      end if;
    end function;
    
    return charfun;
  end if;
end function;


/*p:=5;
e:=2;
ell:=7;
n:=EulerPhi(p^e);
Q<zeta>:=CyclotomicField(n);
M:=MaximalOrder(Q);
R<x>:=PolynomialRing(Rationals());

U,mU:=UnitGroup(Integers(p^e));
log1:=func<x|Eltseq(Inverse(mU)(x))[1]>;
//Conrey character for p^e
conr:=func<n,m|zeta^(log1(n)*log1(m))>;*/



//***************
//characteristic ell Conrey characters


//compute the value r(n) (only makes sense for n prime to ell
rfunc:=func<n,ell|Minimum([r: r in Divisors(EulerPhi(n)) | (((ell^r-1) mod n) eq 0)])>;

function alpha(ell,r)
  if r gt 1 then
    return GF(ell^r).1;
  else
    M,mM:=MultiplicativeGroup(GF(ell));
    return mM(M.1);
  end if;
end function;

//primitive nth root of unity for (n,ell)=1
//otherwise this is defined by George's recipe (see Definition 1)
function zetaellcop(ell,n)
  assert not(n mod ell eq 0);
  return alpha(ell,rfunc(n,ell))^(Integers()!((ell^rfunc(n,ell)-1)/n));
end function;

//general case of zetaell
function zetaell(ell,n)
  if not(n mod ell eq 0) then
    return zetaellcop(ell,n);
  else
    v:=Valuation(n,ell);
    zet:=zetaellcop(ell, Integers()!(n/ell^v));
    F:=Parent(zet);
    deg:=Degree(F);
    zet1:=zet^(ell^((deg-1)*v));
    return zet1;
  end if;
end function;


//generate mod ell Conrey character for odd prime power level
function CharOddPow(p,e,ell)
  assert not (p mod 2 eq 0);
  
  log1:=DiscreteLog(p,e);
  zet:=zetaell(ell,EulerPhi(p^e));
  
  char1:=func<m,n|zet^(log1(m)*log1(n))>;
  
  return char1;
end function;


//mod ell Conrey character for 2-power level
function CharEvenPow(e,ell)
 if e eq 1 then
  char1:=func<m,n|1>;
 end if;
 
 if (e eq 2) then
  char1:=function(m,n)
    if m eq 1 then
      return 1;
    else
      return (-1)^(Integers()!((n-1)/2));
    end if;
  end function;
 end if;
 
 //we use the generators for the multiplicative group (Z/2^e)* provided by MAGMA (which is -1 and 5)
 if (e ge 3) then
  U,mU:=UnitGroup(Integers(2^e));
  inv:=Inverse(mU);
  zet:=zetaell(ell,2^(e-2));
  
  char1:=function(m,n)
  ae,a5:=Explode(Eltseq(inv(Integers(2^e)!m)));
  ae:=signhelp(ae);
  
  be,b5:=Explode(Eltseq(inv(Integers(2^e)!n)));
  be:=signhelp(be);
  
  value:=(zet^a5)^b5;
  
  if (ae eq be) and (ae eq -1) then
    value:=-value;
  end if;
  
  return value;
  end function;
 end if;
 
 return char1;
end function;

//full level Dirichlet character using Conrey notation mod ell
function ConrCharEll(N,ell)
  fact:=Factorization(Abs(N));
  
  if (fact[1][1] eq 2) then
    char2pow:=CharEvenPow(fact[1][2],ell);
    
    charoddpows:=[* CharOddPow(fact[i][1],fact[i][2],ell): i in [2..#fact] *];
    chars:=[*char2pow*] cat charoddpows;
    
    charfun:=function(m,n)
      if (GCD(m,N) gt 1) or (GCD(n,N) gt 1) then
	return GF(ell)!0;
      else
	return &*[char(m,n): char in chars];
      end if;
    end function;
    
    return charfun;
  else
    charoddpows:=[* CharOddPow(fact[i][1],fact[i][2],ell): i in [1..#fact] *];
    chars:=charoddpows;
    
    charfun:=function(m,n)
      if (GCD(m,N) gt 1) or (GCD(n,N) gt 1) then
	return GF(ell)!0;
      else
	return &*[char(m,n): char in chars];
      end if;
    end function;
    
    return charfun;
  end if;
end function;
  
//***************
//Examples

N:=43;
ellpow:=7;
f1:=ConrCharEll(N,ellpow);                                       
//Dirichlet characters (possibly with repetitions)
fulllist:=[<m,[f1(m,n): n in [1..N]]>: m in [1..N] | GCD(m,N) eq 1];

minimalchars:=[fulllist[1]];
charlist:={fulllist[1][2]};
if (#fulllist gt 1) then

for char in fulllist[2..#fulllist] do
  if not (char[2] in charlist) then
    charlist:=charlist join {char[2]};
    minimalchars:=minimalchars cat [char];
  end if;
end for;
end if;


  
  
  
>>>>>>> 00249f6a9db39d2b293da469f159b65566e6b4ac
