//functions for reading and loading data
function LoadAnnaFile(tup)
l:=tup[1];
d:=tup[2];
n:=tup[3];
k:=tup[4];
F<x>:=GF(l^d);
coeffs:=[F!Eltseq(tup[10][k]): k in [2..#tup[10]]];
extra:=20;

return IsReducible(n,k,l,coeffs,extra);
end function;









//initialize files
load "isreducible.m";


load "Anna_data1.m";
//format: [characteristic,deg,level,weight_grading,reducible,cuspidal_lift,dirchar,atkinlehner,n_coeffs,coeffs,ordinary,min_theta_weight,theta_cycle]
