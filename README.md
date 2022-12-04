# Collatz Conjecture Project
### Nate Jackson
Takes in input of two numbers at the command line, calculates the collatz sequence length of all numbers between them.
Then outputs the 10 numbers with the highest sequence lengths, sorted by their sequence lengths
Then outputs the same list now sorted by integer value
## How to compile and run:
### Fortran
```bash
gfortran collatz.f95 -o collatz
./collatz # #
```
(where # represents a positive integer)
### Go
```bash
go run collatz.go # #
```
(where # represents a positive integer)
### Julia
```bash
./collatz.jl # #
```
(where # represents a positive integer)
### Lisp
```bash
./collatz.lisp # #
```
(where # represents a positive integer)
### Rust
Within collatz/ directory:
```bash
cargo run # #
```
(where # represents a positive integer)
