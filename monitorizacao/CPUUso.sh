#host=$(ssh -i cliente ubuntu@192.168.0.101 'hostname')
host=`ssh -i /home/$USER/cliente ubuntu@$1 'hostname'`


nomeT=$(($(echo $host | wc -c)-1+27))
Tam=0

if [ "$nomeT" -le 60 ]
then
	Tam=$((60 - $nomeT))
	Tam=$(($Tam / 2))
	Tam=$(($Tam + 27))
fi

echo "|----------------------------------------------------------|" > ~/$host
printf "%$(echo $Tam)s %s\n" 'Relatorio detalhado do Host' $host >> ~/$host
echo "|----------------------------------------------------------|" >> ~/$host

#printf "%6s %15s %5s %5s %15s\n" 'PID' 'USUÁRIO' 'CPU' 'MEM' 'PROCESSO'

ssh -i /home/$USER/cliente ubuntu@$1 'free' > /home/$USER/TempM

ssh -i /home/$USER/cliente ubuntu@$1 top -b -n 1 > /home/$USER/tempTop

cat tempTop | sed '1,6d' | sed 's/^ *//' | sed 's/ * /;/g' | awk -F";" '{printf "%6s %15s %5s %15s\n",$1,$2,$9,$12}' >> /home/$USER/$host

#echo "Mem Total - " $(top -b -n 1 | grep "KiB Mem" | cut -d"," -f 3 | sed 's/ * /;/g' | cut -d";" -f 3)

echo "CPU Livre - $(ssh -i cliente ubuntu@$1 'top -bn1' | grep Cpu | awk -F"," '{print $7"."$8}') | cut -d" " -f 2) %" >> ~/$host

cat ~/$host
java MonitorizacaoJ andersofelipe.moral14@gmail.com 145236987 $(cat ~/monitorizacao/$host)

echo "Digite os PID's que desejar eliminar ou 0 para sair"
read PID

if [ $PID != 0 ] then
	ssh -i cliente ubuntu@$1 'kill $PID'
fi
