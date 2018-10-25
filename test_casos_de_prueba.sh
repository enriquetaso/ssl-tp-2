#!/bin/bash

set -o xtrace

echo "Compilamos el interprete del lenguaje MICRO:"

bison -yd micro.y
Flex micro.l
gcc y.tab.c lex.yy.c -o salida

for filename in test_camino_simple test_error_cuando_asigno_float test_error_cuando_supera_32 test_error_identificador_numero test_escribir test_leer; do
	./salida CasosDePrueba/"$filename".txt
done




