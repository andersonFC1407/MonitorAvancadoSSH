# Monitor Avançado

### Equipe: Anderson Felipe Costa
###        Antonio Thiago Costa

## Objetivo
O objetivo do trabalho é enviar relatórios detalhados para um e-mail sobre o uso da cpu e da memória ram para isso foi criado um conjunto de scripts que realiza o monitoramento e envia relatorios detalhados do uso, que só são criados no momento em que a pouco espaço ocioso no caso da cpu e pouco espaço de memoria no caso da ram,  e 2 tomam ação de matar processos, a localização dos scripts é em uma maquina servidor que no nosso caso é o próprio SO(Ubuntu Desktop) do computador, na pasta monitorização e um cliente que é uma maquina virtual, para o envio do e-mail foi criado programa em java com a extenção .jar.

A comunicação é realizada através de SSH e uma aplicação Java básica para o envio de informações para o email do gerente.
