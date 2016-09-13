# Mod l modular forms

In this repository we store raw data for the collection [modlmf] in the database [mod_l_eigenvalues] for the [LMFDB](https://github.com/LMFDB/lmfdb).


### Contents of this document
1. Description of the data format for mod ell modular forms. 
2. Description of the labels for mod ell modular forms.
3. Description of the labels for "Dirichlet's characters" modulo ell. 

### 1. Data format for mod ell modular forms

Each line in a data file will contain a single comma-separated list (enclosed in square brackets) correspond to one Galois orbit of mod-ell modular forms. The elements of the list are as follows, in this exact order:

* **characteristic** (integer): the characteristic of the base ring of the form, a prime ell
* **deg** (integer): degree of base field over prime field
* **level** (integer): minimal level of the form, that is the smallest level in which the eigenvalue system does occurr. If the associated representation is irreducible this is the Artin conductor away from l.
* **weight_grading** (integer): weight of the form modulo ell-1
* **reducible** (list [string, integer, string, integer, integer]): this means that the associated representation is reducible of the form 
<p align="center">
chi_1 cycl^a + chi_2 cycl^b,                  with a < b
</p>
where chi_1, chi_2 are mod ell Dirichlet characters and cycl is the mod ell cyclotomic character. This is the format
<p align="center">
[dirchar_label(chi_1), power of cyclotomic a, dirchar_label(chi_2), power of cyclotomic b, eisenstein_weight] 
</p>

   The dirchar_label is the **full** label of the character.
   The eisenstein_weight is the minimal weight of the Eisenstein lift of smallest weight.

Please set as **""** in the **irreducible** case.

* **cuspidal_lift**(list [integer, string, string, string]): description of the characteristic zero cuspidal lift of smallest weight and smalles Galois orbit (alphabetical order). This consists of 
    * (int) the weight of the newform, 
    * (string) the label of the newform (level.weight.m.galois_orbit, where the Dirichlet character considered if level.m)
    * (string) the polynomial giving the Hecke eigenvalue field.
    * (string) the ideal used for the reduction, in terms of the generators e.g. "(3, x + 1)", where x satisfies the polynomial in the previous field. 
* **dirchar** (int): label of the mod ell Dirichlet character, see part 3. For example "ell.N.1" for the trivial character. 
* **atkinlehner** (list of two-element lists of integers): [[int(p^e), int(W_{p^e})] for p^e exactly dividing N] 
* **n_coeffs** (integer): the number of Fourier coefficients
* **coeffs** (list of strings): coefficients of the q-expansion as strings ["a_0", "a_1", ... , "a_(n_coeffs - 1)"]. The finite field where the coefficients belongs is represented using Conway polynomials, and the generator is denoted by x.
* **ordinary**(boolean): 1 means ordinary (a_ell != 0) and 0 for non-ordinary
* **min_theta_weight** (integer): minimum weight in a theta cycle
* **theta_cycle**(list of tuples [int, str]): theta cycle, formattes as list of [weight, label of the Galois orbit]

We insist that all strings be enclosed in straight double quotes, "like so". 
All unknown fields (whether integers or strings) should be entered as "".

Formatting of the Fourier coefficients: each coefficient is a string representing an element of F_(ell^d), written as a polynomial in x, where x is a Conway generator of F_(ell^d).

Examples:  
```
[3, 1, 1, 0, ['3.1.1', 0, '3.1.1', 1, 0], [12, '1.12.1.a', 'x', '(3)'], '3.1.1', [[1, 1]], 200, ['0', '1', '0', '0', '1', '0', '0', '2', '0', '0', '0', '0', '0', '2', '0', '0', '1', '0', '0', '2', '0', '0', '0', '0', '0', '1', '0', '0', '2', '0', '0', '2', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '2', '0', '0', '1', '0', '0', '2', '0', '0', '0', '0', '0', '2', '0', '0', '2', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '2', '0', '0', '1', '0', '0', '2', '0', '0', '0', '0', '0', '2', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '2', '0', '0', '2', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '2', '0', '0', '2', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '2', '0', '0', '2', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2', '0', '0', '0', '0', '0', '2'], 0, 12, [12]]

[13, 1, 1, 0, '', [12, '1.12.1.a', 'x', '(13)'], '13.1.1', [[1, 1]], 200, ['0', '1', '2', '5', '10', '7', '10', '0', '6', '3', '1', '0', '11', '8', '0', '9', '7', '4', '6', '3', '5', '0', '0', '11', '4', '2', '3', '9', '0', '1', '5', '12', '11', '0', '8', '0', '4', '3', '6', '1', '3', '6', '0', '11', '0', '8', '9', '1', '9', '11', '4', '7', '2', '10', '5', '0', '0', '2', '2', '7', '12', '3', '11', '0', '12', '4', '0', '9', '1', '3', '0', '10', '5', '6', '6', '10', '4', '0', '2', '4', '10', '5', '12', '9', '0', '2', '9', '5', '0', '8', '3', '0', '6', '8', '2', '8', '3', '7', '9', '0', '7', '12', '1', '3', '9', '0', '7', '2', '12', '4', '0', '2', '0', '7', '4', '12', '10', '11', '1', '0', '2', '7', '6', '4', '3', '10', '0', '8', '12', '3', '8', '5', '0', '0', '5', '11', '11', '7', '6', '1', '0', '5', '7', '0', '8', '7', '12', '3', '4', '10', '7', '8', '5', '12', '0', '6', '10', '0', '8', '11', '12', '0', '10', '8', '8', '0', '5', '3', '0', '12', '4', '9', '6', '5', '10', '0', '0', '9', '3', '0', '2', '11', '0', '2', '1', '8', '3', '0', '10', '0', '3', '2', '8', '6', '1', '7', '6', '10', '0', '7'], 0, 12, [26, 16, 30, 44, 58, 72, 86, 100, 114, 128, 142, 156]]
```



### 2. Label for a Galois orbit of mod ell modular forms. 

The label of a Galois orbit of mod ell modular forms is given by

<p align="center" ><b>
finite_field . level . weight . dirchar_index . letter
</b></p>  
where 
* **finite_field** is given by the string characterist+e+degree (unless the degree is 1, so the finite_field is given by the characteristic)
* **level** is the minimal level as above
* **weight** is the weight_grading (modulo ell -1)
* **dirchar_index** comes from the label of the mod ell Dirichlet label which is characteristic.level.m
* the **letter** denotes the Galois orbit, ordered looking at the q_expansion (at the moment this is relies on the code which computes the data).


### 3. Label description for mod-ell "Dirichlet characters." 

See file [Schaeffer_chars.pdf] and annotated version in this repository with a description of adapting the Conrey Dirichlet character notation to (F_ell)bar. 
The labels will look as follows: "ell.q.n" means character (Z/qZ)* -> (F_ell)-bar* corresponding to chi_q(n, -) in the Conrey notation with the Conway system of generators taking the place of exp(-). If ell does not divide the value of the Euler phi function of q, then the part of the label after the characteristic corresponds to the characteristic zero labels. Otherwise check the file for more information.

