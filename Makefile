# DO NOT EDIT THIS FILE

.PHONY: test check

build:
	dune build

code:
	-dune build
	code .
	! dune build --watch

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

game:
	OCAMLRUNPARAM=b dune exec src/main.exe
