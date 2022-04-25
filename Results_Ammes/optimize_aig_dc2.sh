#!/bin/bash

FILE_PATH="$1"
REPS="$2"
MODE="$3"

#SE MODE 0 ou nenhum valor inserido, executa até alcançar REPS vezes sem otimizar o número de ANDS. (Otimiza até saturar)
#SE MODE >0, executa REPS vezes, indepente se ainda pode otimizar. (Executa o comando REPS vezes)

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

if [ -z "${MODE}" ]; then
	MODE=0
elif [ ${MODE} -gt 1 ]; then
	MODE=1
fi


return=$(./abc -c "r ${FILE_PATH};ps;q")
value=$(echo $return| cut -d'=' -f 4)
and=$(echo $value | sed 's/[^0-9]*//g')
value=$(echo $return| cut -d'=' -f 5)
level=$(echo $value | sed 's/[^0-9]*//g')
count=0
while [ $count -lt ${REPS} ]; do
	last_and=$and
	last_level=$level
	return=$(./abc -c "r ${FILE_PATH};dc2;ps;w ${FILE_PATH};q")
	value=$(echo $return| cut -d'=' -f 4)
	and=$(echo $value | sed 's/[^0-9]*//g')
	value=$(echo $return| cut -d'=' -f 5)
	level=$(echo $value | sed 's/[^0-9]*//g')
	if [ ${and} = ${last_and} -o ${MODE} = 1 ]; then
		count=`expr $count + 1`
	else
		count=0
	fi
done
