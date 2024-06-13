#!/bin/bash

for i in {1..30}
do
    echo "Execution $i"

    # Executa os comandos do script 1
    sudo tcpdump -n -i enp7s0 udp port 8000 or udp port 8001 -w sender_$i.pcap &
    tcpdump_pid=$!
    ffmpeg -re -i bbb_1minuto.mp4 -f rtsp rtsp://localhost:8554/mystream 

    # Espera 61 segundos
    sleep 3

    # Mata o processo tcpdump
    sudo kill $tcpdump_pid

    echo "Execution $i completed"
done
