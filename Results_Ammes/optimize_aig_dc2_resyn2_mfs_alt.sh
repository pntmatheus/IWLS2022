#!/bin/bash

FILE_PATH="$1"
REPS="$2"

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


last_i_and=0
last_f_and=0
optcount=0

return=$(./abc -c "r ${FILE_PATH};ps;q")
value=$(echo $return| cut -d'=' -f 4)
init_and=$(echo $value | sed 's/[^0-9]*//g')
echo $init_and

while [ $optcount -lt ${REPS} ]; do
	return=$(./abc -c "r ${FILE_PATH};ps;q")
	value=$(echo $return| cut -d'=' -f 4)
	init_and=$(echo $value | sed 's/[^0-9]*//g')
	value=$(echo $return| cut -d'=' -f 5)
	level=$(echo $value | sed 's/[^0-9]*//g')
	sh optimize_aig_alt_10.sh ${FILE_PATH}

	return=$(./abc -c "r ${FILE_PATH};ps;q")
	value=$(echo $return| cut -d'=' -f 4)
	final_and=$(echo $value | sed 's/[^0-9]*//g')

	if [ ${final_and} = ${init_and} -a ${final_and} = ${last_f_and} -a ${last_i_and} = ${init_and} ]; then
		optcount=`expr $optcount + 1`
	else
		optcount=0
	fi

	last_i_and=${init_and}
	last_f_and=${final_and}

	return=$(./abc -c "r ${FILE_PATH};logic;mfs -C 0 -W $level -D 0 -M 0 -L $level -d -r -e;st;dc2;resyn2;w ${FILE_PATH};q")
	return=$(./abc -c "r ${FILE_PATH};ps;q")
	value=$(echo $return| cut -d'=' -f 4)
	final_f_and=$(echo $value | sed 's/[^0-9]*//g')

done

echo $init_and $final_and $final_f_and