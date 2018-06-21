#!/bin/bash

host=$(hostname)
users=$(whoami)

nomeT=$(($(echo $host | wc -c)-1+27))
echo $nomeT
Tam=0

if [ "$nomeT" -le 60 ]
then
	Tam=$((60 - $nomeT))
	Tam=$(($Tam / 2))
	Tam=$(($Tam + 27))
fi

echo $Tam

echo "|----------------------------------------------------------|"
printf "%$(echo $Tam)s %s\n" 'Relatorio detalhado do Host' $host
echo "|----------------------------------------------------------|"

#printf "%6s %15s %5s %5s %15s\n" 'PID' 'USUÁRIO' 'CPU' 'MEM' 'PROCESSO'

for i in $(echo $users)
do
	memT=$(free | grep Mem | sed 's/^ *//' | sed 's/ * /;/g' | awk -F";" '{print $2}')
	memU=$(free | grep Mem | sed 's/^ *//' | sed 's/ * /;/g' | awk -F";" '{print $3}')

	#top -b -u $i -n 1 | grep $i | sed 's/^ *//' | sed 's/ * /;/g' | awk -F";" '{printf "%6s %15s %5s %5s %15s\n",$1,$2,$9,$10,$12}'
	top -b -n 1 | sed '1,6d' | sed 's/^ *//' | sed 's/ * /;/g' | awk -F";" '{printf "%6s %15s %5s %5s %15s\n",$1,$2,$9,$10,$12}'
	#echo "Mem Total - " $(top -b -n 1 | grep "KiB Mem" | cut -d"," -f 3 | sed 's/ * /;/g' | cut -d";" -f 3)
	echo "Mem Total - $(perl -e "print $memT/1000000") GB"
	echo "Mem em uso - $(perl -e "print $memU/1000000") GB"
	echo "Mem em uso % - $(perl -e "print $memU/$memT*100")%"
done
