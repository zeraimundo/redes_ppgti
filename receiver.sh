#!/bin/bash


    # Executa os comandos do script 2
    sudo tcpdump -n -i enp7s0 -w receive_$1.pcap &
    tcpdump_pid=$! && sleep 2
    ffplay -autoexit -x 1 -y 1 -left -1000 -top -1000 -rtsp_transport tcp rtsp://10.0.4.10:8554/mystream
    # Espera 3 segundos
    sleep 3

    # Mata o processo tcpdump
    sudo kill $tcpdump_pid

    # Certifica-se de que todos os processos tcpdump estão mortos
    sudo pkill -f tcpdump

