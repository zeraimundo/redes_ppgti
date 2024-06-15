#!/bin/bash

for i in {1..30}
do
    echo "Execution $i"

    # Executa os comandos do script 1
    sudo tcpdump -n -i enp7s0 udp port 8000 or udp port 8001 -w sender_$i.pcap &
    tcpdump_pid=$!
    ffmpeg -re -i bbb_1minuto.mp4 -vf scale=1280:720  -b:v 80M -an -f rtsp rtsp://localhost:8554/mystream 

    # Espera 3 segundos
    sleep 3

    # Mata o processo tcpdump
    sudo kill $tcpdump_pid

    # Certifica-se de que todos os processos tcpdump estão mortos
    sudo pkill -f tcpdump

    echo "Execution $i completed"
done

