#host=$(ssh -i cliente ubuntu@192.168.0.101 'hostname')
host=`ssh -i cliente ubuntu@$1 'hostname'`


nomeT=$(($(echo $host | wc -c)-1+27))
Tam=0

if [ "$nomeT" -le 60 ]
then
	Tam=$((60 - $nomeT))
	Tam=$(($Tam / 2))
	Tam=$(($Tam + 27))
fi

echo "|----------------------------------------------------------|" > $host
printf "%$(echo $Tam)s %s\n" 'Relatorio detalhado do Host' $host >> $host
echo "|----------------------------------------------------------|" >> $host

#printf "%6s %15s %5s %5s %15s\n" 'PID' 'USUÁRIO' 'CPU' 'MEM' 'PROCESSO'

ssh -i cliente ubuntu@$1 'free' > tempM

memU=$(cat tempM | grep Mem | sed 's/^ *//' | sed 's/ * /;/g' | awk -F";" '{print $3}')

memT=$(cat tempM | grep Mem | sed 's/^ *//' | sed 's/ * /;/g' | awk -F";" '{print $2}')

#top -b -u $i -n 1 | grep $i | sed 's/^ *//' | sed 's/ * /;/g' | awk -F";" '{printf "%6s %15s %5s %5s %15s\n",$1,$2,$9,$10,$12}'

ssh -i cliente ubuntu@$1 top -b -n 1 > tempTop

cat tempTop | sed '1,6d' | sed 's/^ *//' | sed 's/ * /;/g' | awk -F";" '{printf "%6s %15s %5s %15s\n",$1,$2,$10,$12}' >> $host

#echo "Mem Total - " $(top -b -n 1 | grep "KiB Mem" | cut -d"," -f 3 | sed 's/ * /;/g' | cut -d";" -f 3)

echo "Mem Total - $(perl -e "print $memT/1000000") GB" >> $host
echo "Mem em uso - $(perl -e "print $memU/1000000") GB" >> $host
echo "Mem em uso % - $(perl -e "print $memU/$memT*100")%" >> $host

cat $host
java -jar Monitorizacao.jar andersonfelipe.moral14@gmail.com 145236987 $host

echo "Digite os PID's que desejar eliminar com espaço entre eles ou 0 para sair"
read PID

if [ $PID != 0 ]
then
	ssh -i cliente ubuntu@$1 'kill $PID'
fi
