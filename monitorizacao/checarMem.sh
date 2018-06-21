#!/bin/bash

mem=$(ssh -i cliente ubuntu@$1 'free -m' | grep Mem | awk -F" " '{print $7}')

if [ $mem -lt $2 ]
then
	./MemUso.sh $1
fi
