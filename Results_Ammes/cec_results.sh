#!/bin/bash

#Aqui pode ser uma lista de pastas, no eu só testei se os aigs na pasta ./aigs_espresso/espresso eram equivalentes
FOLDERS="./aigs_espresso/espresso"

#Os arquivos do contest vão de ex00 até ex99, então x e y vão de 0 a 9 e eu testo as combinações
for x in $(seq 0 9); do
	for y in $(seq 0 9); do
		echo ex$x$y
		for FOLDER in ${FOLDERS}; do
			#Comparei com as tabelas verdades que tavam na minha pasta benchmarks, tem que ver aí onde ta as tuas.
			return=$(./abc -c "read_truth -xf ../benchmarks/ex$x$y.truth;cec $FOLDER/ex$x$y.aig;q")
			value=$(echo $return | cut -d'.' -f 7)
			#return tem tudo o que foi printado pelo abc, enquanto o value é pra ter só se é ou não equivalente
			#Eventualmente o value da ruim e é melhor olhar o return.
			
			#echo $return
			echo $value
		done
		echo
	done
done