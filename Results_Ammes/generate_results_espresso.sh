#!/bin/bash


FOLDERS="./aigs_espresso/aigs_dc2 ./aigs_espresso/aigs_resyn2 ./aigs_espresso/aigs_sep ./aigs_espresso/aigs_alt"


for FOLDER in ${FOLDERS}; do
	echo -n '\t'${FOLDER}'\t''\t'
done
echo 

echo -n aig
for FOLDER in ${FOLDERS}; do
	echo -n '\t'and'\t'level'\t'
done
echo

for x in $(seq 0 9); do
	for y in $(seq 0 9); do
		echo -n ex$x$y
		for FOLDER in ${FOLDERS}; do
			return=$(./abc -c "r ${FOLDER}/ex$x$y.aig;ps;q")
			value=$(echo $return| cut -d'=' -f 4)
			and=$(echo $value | sed 's/[^0-9]*//g')
			value=$(echo $return| cut -d'=' -f 5)
			level=$(echo $value | sed 's/[^0-9]*//g')
			echo -n '\t'${and}'\t'${level}'\t'
		done
		echo
	done
done