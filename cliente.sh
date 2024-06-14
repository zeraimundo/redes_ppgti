#!/bin/bash

for i in {1..30}
do
    echo "Execution $i"

    # Executa os comandos do script 2
    sudo tcpdump -n -i enp7s0 udp port 8000 or udp port 8001 -w receive_$i.pcap &
    tcpdump_pid=$!
    ffplay -autoexit rtsp://10.0.4.10:8554/mystream 

    # Espera 3 segundos
    sleep 3

    # Mata o processo tcpdump
    sudo kill $tcpdump_pid

    # Certifica-se de que todos os processos tcpdump estão mortos
    sudo pkill -f tcpdump

    echo "Execution $i completed"
done

