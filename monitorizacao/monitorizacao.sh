#!/bin/bash

menu(){
	echo "1 - Adicionar Maquina"
	echo "2 - Adicionar Condicão"
	echo "3 - Remover Maquina"
	echo "0 - Sair"
}


echo "|---------------------------------------------------|"
echo "              Monitoramento Avançado com SSH         "
echo "|---------------------------------------------------|"

while true
do
menu
read a

case $a in
	1) echo "Informe o nome do Host"
	   read host
	   echo "Informe o IP"
	   read ip
	   echo $host:$ip >> /home/$USER/monitorizacao/maquinas
	   ;;
	2) echo "Informe o IP para associar esta regra"
	   read ip
	   echo "CPU ou MEMORIA"
	   read op
	   if [ $op == "CPU" ]; then
		   echo "Informe o Minimo"
		   read cpu
		   host=$(cat /home/$USER/monitorizacao/maquinas | grep $ip)
		   echo $host:$cpu >> /home/$USER/monitorizacao/CPU
	   elif [ $op == "MEMORIA" ]; then
		   echo "Minimo de Mémoria RAM em MB permitida"
                   read ram
                   host=$(cat /home/$USER/monitorizacao/maquinas | grep $ip)
                   echo $host:$ram >> /home/$USER/monitorizacao/MEMORIA
	   else
		   echo "Opção Invalida"
	   fi
	   ;;
	0)
		exit -1
	   ;;
	3) cat /home/$USER/monitorizacao/maquinas
           echo "Informe o IP da maquina"
	   read ip
	   cat /home/$USER/monitoramento/maquinas | grep -v $ip >> /home/$USER/monitorizacao/maquinas
	   cat /home/$USER/monitoramento/CPU | grep -v $ip >> /home/$USER/monitorizacao/CPU
	   cat /home/$USER/monitoramento/MEMORIA | grep -v $ip >> /home/$USER/monitorizacao/MEMORIA
	   ;;
	default)
		echo "Opção Invalida"
esac
done


