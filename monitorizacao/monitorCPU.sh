#!/bin/bash

while true
do
	for i in $(cat CPU)
	do
		IP=$(echo $i | cut -d":" -f 1)
		limite=$(echo $i | cut -d":" -f 3)
		teste=$(ssh -i cliente ubuntu@$ip 'uptime')
		if [ $(echo $teste | cut -d":" -f 1) == 'ssh' ]
		then
			echo "host offline"
			continue
		fi
		gnome-terminal --execute bash -c "./checarCPU $IP $limite"
	done
	sleep 180
done
