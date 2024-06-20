#!/bin/bash
    
    # Executa os comandos do script 1
    
    sudo tcpdump -n -i enp7s0 -w sender_$1.pcap &
    tcpdump_pid=$!
    
    ffmpeg -re -i video.mp4 -vf scale=1280:720 -b:v 80M  -an -f rtsp -rtsp_transport tcp rtsp://localhost:8554/mystream
#    ffmpeg -re -i video.mp4 -vf scale=1920:1080 -b:v 80M  -an -f rtsp -rtsp_transport tcp rtsp://localhost:8554/mystream
#    ffmpeg -re -i video.mp4 -vf scale=3840:2160 -b:v 80M  -an -f rtsp -rtsp_transport tcp rtsp://localhost:8554/mystream
    sleep 3

    # Mata o processo tcpdump
    sudo kill $tcpdump_pid

    # Certifica-se de que todos os processos tcpdump estão mortos
    sudo pkill -f tcpdump
