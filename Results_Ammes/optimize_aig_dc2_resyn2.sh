#!/bin/bash

FILE_PATH="$1"
REPS="$2"
SCRIPTS_REPS="$3"
SCRIPTS_MODE="$4"

#Executa os dois scripts de otimização, até que fique REPS vezes sem otimizar as ANDS
#SE SCRIPTS_MODE 0 ou nenhum valor inserido, executa cada script até alcançar SCRIPTS_REPS vezes sem otimizar o número de ANDS. (Otimiza até saturar)
#SE SCRIPTS_MODE >0, executa cada script REPS vezes, indepente se ainda pode otimizar. (Executa o comando SCRIPTS_REPS vezes)

if [ -z "${FILE_PATH}" ]; then
	echo Insira o caminho de um aig.
	return
fi

if [ -z "${REPS}" ]; then
	REPS=10
elif [ ${REPS} = 0 ]; then
	echo REPS tem que ser maior que 0.
	return
fi



optcount=0
while [ $optcount -lt ${REPS} ]; do
	return=$(./abc -c "r ${FILE_PATH};ps;q")
	value=$(echo $return| cut -d'=' -f 4)
	init_and=$(echo $value | sed 's/[^0-9]*//g')
	sh optimize_aig_dc2.sh ${FILE_PATH} ${SCRIPTS_REPS} ${SCRIPTS_MODE}

	return=$(./abc -c "r ${FILE_PATH};ps;q")
	value=$(echo $return| cut -d'=' -f 4)
	part_and=$(echo $value | sed 's/[^0-9]*//g')

	sh optimize_aig_resyn2.sh ${FILE_PATH} ${SCRIPTS_REPS} ${SCRIPTS_MODE}
	return=$(./abc -c "r ${FILE_PATH};ps;q")
	value=$(echo $return| cut -d'=' -f 4)
	final_and=$(echo $value | sed 's/[^0-9]*//g')

	if [ ${final_and} = ${init_and} ]; then
		optcount=`expr $optcount + 1`
	else
		optcount=0
	fi

	echo $init_and $part_and $final_and

done
