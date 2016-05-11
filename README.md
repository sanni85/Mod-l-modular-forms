# Mod-l-modular-forms

In this repository we store raw data for the [Mod ell modular forms database]  for the [LMFDB](https://github.com/LMFDB/lmfdb).

Each line in a data file will contain a single comma-separated list (enclosed in square brackets) correspond to one mod-ell modular form. The elements of the list are as follows, in this exact order:

* **char** (integer): the characteristic of the base ring of the form, a prime ell or a prime power ell^n
* **dimension** (integer): if char is prime, dimension of base field of form over prime field; otherwise 1
* **level** (integer): level of the form
* **conductor** (integer): minimal level that carries the representation attached to the form
* **weight** (integer): if char is prime, weight grading of the form modulo ell - 1; otherwise TBD
* **dirchar** (string): label of the Dirichlet character TBD; "1" if level is Gamma0(N) 
* **atkinlehnereivals** (list of two-element lists of integers): [[int(p^e), int(W_{p^e})] for p^e exactly dividing N] 
* **numberofFouriercoeffs** (integer): the number of Fourier coefficients
* **Fouriercoeffs** (list of strings): ["a_0", "a_1", ... , "a_(numberofFouriercoeffs - 1)"]

We insist that all strings be enclosed in straight double quotes, "like so"; unknown strings should look like "".

Example of line corresponding to the unique normalized cuspform of level 3 and weight 6 modulo 2:  
```
[2, 1, 3, 1, 0, "1", [[3, 1]], 160, ["0", "1", "0", "1", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"]]
```

This Repository contains the following files:

1. **finitefields** txt file with the following information: [ell, d, "poly"]. 

REST TO BE INSERTED 
