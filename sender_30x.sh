#!/bin/bash

for i in {1..30}
do
    echo "Execution $i"

    sudo tcpdump -n -i ens18 -w server$i.pcap &
    tcpdump_pid=$!
    
#     ffmpeg -re -i 62s.mp4 -vf scale=1280:720 -b:v 100M  -an -f rtsp -rtsp_transport tcp rtsp://localhost:8554/mystream
     ffmpeg -re -i video.mp4 -vf scale=1280:720 -b:v 100M  -an -f rtsp -rtsp_transport tcp rtsp://localhost:8554/mystream
#    ffmpeg -re -i video.mp4 -vf scale=1920:1080 -b:v 100M  -an -f rtsp -rtsp_transport tcp rtsp://localhost:8554/mystream
#    ffmpeg -re -i video.mp4 -vf scale=3840:2160 -b:v 100M  -an -f rtsp -rtsp_transport tcp rtsp://localhost:8554/mystream
    sleep 1 

    # Mata o processo tcpdump
    sudo kill $tcpdump_pid

    # Certifica-se de que todos os processos tcpdump estão mortos
    sudo pkill -f tcpdump

    echo "Execution $i completed"
done
