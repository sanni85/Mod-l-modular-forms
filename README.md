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
chi_1 cycl^a + chi_2 cycl^b,                  a<b
</p>
where chi_1, chi_2 are mod ell Dirichlet characters and cycl is the mod ell cyclotomic character. Please set as **""** in the **irreducible** case. This is the format
<p align="center">
[dirchar_label(chi_1), power of cyclotomic a, dirchar_label(chi_2), power of cyclotomic b, eisenstein_weight] 
</p>
The eisenstein_weight is the minimal weight of the Eisenstein lift of smallest weight.
* **cuspidal_lift**(list [integer, string, string, string]): description of the characteristic zero cuspidal lift of smallest weight and smalles Galois orbit (alphabetical order). This consists of 
    * (int) the weight of the newform, 
    * (string) the label of the newform (level.weight.m.galois_orbit, where the Dirichlet character considered if level.m)
    * (string) the polynomial giving the Hecke eigenvalue field, 
    * (string) the generators of the ideal used for the reduction.
* **dirchar** (string): label of the mod ell Dirichlet character, see part 3. 
* **atkinlehner** (list of two-element lists of integers): [[int(p^e), int(W_{p^e})] for p^e exactly dividing N] 
* **n_coeffs** (integer): the number of Fourier coefficients
* **coeffs** (list of strings): coefficients of the q-expansion as strings ["a_0", "a_1", ... , "a_(n_coeffs - 1)"].
* **ordinary**(boolean): 1 means ordinary (a_ell != 0) and 0 for non-ordinary
* **min_theta_weight** (integer): minimum weight in a theta cycle
* **theta_cycle**(list of tuples [int, str]): theta cycle, formattes as list of [weight, label of the Galois orbit]

We insist that all strings be enclosed in straight double quotes, "like so". 
All unknown fields (whether integers or strings) should be entered as "".

Formatting of the Fourier coefficients: each coefficient is a string representing an element of F_(ell^d), written as a polynomial in x, where x is a Conway generator of F_(ell^d).

Example:  
```

```

Example of a form defined over a non-trivial extension of F_ell: 
```

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

