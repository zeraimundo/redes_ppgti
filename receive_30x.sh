#!/bin/bash

for i in {1..30}
do
    echo "Execution $i"

    # Executa os comandos do script 2
    sudo tcpdump -n -i ens18 -w client$i.pcap &
    tcpdump_pid=$! && sleep 2
    ffplay -autoexit -x 1 -y 1 -left -1000 -top -1000 -rtsp_transport tcp rtsp://10.0.4.10:8554/mystream
#    ffplay -autoexit -rtsp_transport tcp rtsp://10.0.4.10:8554/mystream -loglevel debug 2>&1 | tee ffplay_log.txt
    # Espera 3 segundos
    sleep 1 

    # Mata o processo tcpdump
    sudo kill $tcpdump_pid

    # Certifica-se de que todos os processos tcpdump estão mortos
    sudo pkill -f tcpdump

    echo "Execution $i completed"
done
