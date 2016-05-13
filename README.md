# Mod-l-modular-forms

In this repository we store raw data for the [Mod ell modular forms database]  for the [LMFDB](https://github.com/LMFDB/lmfdb).

Each line in a data file will contain a single comma-separated list (enclosed in square brackets) correspond to one mod-ell modular form. The elements of the list are as follows, in this exact order:

* **char** (integer): the characteristic of the base ring of the form, a prime ell
* **degree** (integer): degree of base field over prime field
* **level** (integer): level of the form
* **conductor** (integer): minimal level that carries the representation attached to the form
* **minweight** (integer): minimal weight that this particular form appears in in this level.
* **dirchar** (string): label of the mod-ell "Dirichlet character"; details TBD. "1" if level is Gamma0(N) 
* **atkinlehnereivals** (list of two-element lists of integers): [[int(p^e), int(W_{p^e})] for p^e exactly dividing N] 
* **numberofFouriercoeffs** (integer): the number of Fourier coefficients
* **Fouriercoeffs** (list of strings): ["a_0", "a_1", ... , "a_(numberofFouriercoeffs - 1)"].

We insist that all strings be enclosed in straight double quotes, "like so". 
All unknown fields (whether integers or strings) should be entered as "".

Formatting of the Fourier coefficients: each coefficient is a string representing an element of F_(char^d), written as a polynomial in x, where x is a Conway generator of F_(char^d).

Example of line corresponding to the unique normalized cuspform of level 3 and weight 6 modulo 2:  
```
[2, 1, 3, 1, 6, "1", [[3, 1]], 160, ["0", "1", "0", "1", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]]
```

Example of a form not defined over F_p: 
```
[11, 2, 5, "", 8, "1", [[ 5, 1 ]], 51, ["0", "1", "4*x + 2", "x + 8", "3*x + 9", "7", "6*x + 8", "4*x + 8", "7*x + 2", "9*x + 9", "6*x + 3", "5*x + 7", "x", "10*x + 1", "5*x + 6", "7*x + 1", "3*x + 6", "5*x + 4", "1", "7*x + 6", "10*x + 8", "x + 1", "8*x + 7", "7*x", "9*x + 2", "5", "8*x + 10", "9*x + 4", "9*x + 4", "2*x + 1", "9*x + 1", "9*x + 10", "7*x + 7", "x + 2", "7*x + 1", "6*x + 1", "7*x + 5", "9*x + 6", "7*x", "10", "5*x + 3", "5*x + 7", "5", "2*x + 6", "5*x", "8*x + 8", "5*x + 10", "4", "9*x + 9", "7*x + 4", "9*x + 10"]]
```

File prepared by Anna Medvedovsky.
