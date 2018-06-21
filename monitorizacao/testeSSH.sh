#!/bin/bash

IPS=$(cat maquinas | cut -d":" -f 2)

for i in $(cat maquinas | cut -d":" -f 2)
do
	ssh -i cliente ubuntu@$i 'uptime' 2> temp.txt

	teste=$(cat temp.txt | cut -d":" -f 1)
	echo $teste
	rm temp.txt

	if [ $teste == 'ssh' ]
	then
        	echo "Host Indisponivel"
	fi
done
