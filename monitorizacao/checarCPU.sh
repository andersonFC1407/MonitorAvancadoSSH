#!/bin/bash

cpu=$(ssh -i cliente ubuntu@$1 'top -bn1' | grep Cpu | awk -F"," '{print $7"."$8}' | cut -d" " -f 2
)

if [ $cpu -lt $2 ]
then
	./CPUUso $1
fi
