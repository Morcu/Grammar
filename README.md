# Parser

A parser from a **c**'s subset to **forth** (https://forth-standard.org/)

## Compiling and execution

### Compiling

Write commands

1. bison gramar.y
2. gcc gramar.tab.c -o gramarExecution

## Execution

### only the parse
Write command

1. ./gramarExecution < pruebas/_name of the test_ 

### parse + execution with forh

1. Download gforth-0.7.3.tar.gz  (http://www.complang.tuwien.ac.at/forth/gforth/)
2. Extract the file
3. On the directory  _gforth-0.7.3_ Write command ./configure and then make

4. on the directory where you have the gramar.tab.c Write command ./gramarExecution < pruebas/_the name of the test_ | gforth-0.7.3/./gforth

