#!/bin/bash

while true
do
	for i in $(cat MEMORIA)
	do
		IP=$(echo $i | cut -d":" -f 2)
		echo $IP
		limite=$(echo $i | cut -d":" -f 3)
		teste=$(ssh -i cliente ubuntu@$IP 'uptime')

		if [ "$(echo $teste | cut -d":" -f 1)" == 'ssh' ];
		then
			echo "host offline"
			continue
		fi
		./checarMem.sh $IP $limite
	done
	sleep 60
done
