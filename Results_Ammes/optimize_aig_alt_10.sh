#!/bin/bash

FILE_PATH="$1"

if [ -z "${FILE_PATH}" ]; then
	echo Insira o caminho de um aig.
	return
fi


return=$(./abc -c "r ${FILE_PATH};ps;q")
value=$(echo $return| cut -d'=' -f 4)
and=$(echo $value | sed 's/[^0-9]*//g')
value=$(echo $return| cut -d'=' -f 5)
level=$(echo $value | sed 's/[^0-9]*//g')
last_and=0
while [ ${and} -ne ${last_and} ]; do
	last_and=$and
	return=$(./abc -c "r ${FILE_PATH};dc2;resyn2;dc2;resyn2;dc2;resyn2;dc2;resyn2;dc2;resyn2;ps;w ${FILE_PATH};q")
	value=$(echo $return| cut -d'=' -f 4)
	and=$(echo $value | sed 's/[^0-9]*//g')
done
