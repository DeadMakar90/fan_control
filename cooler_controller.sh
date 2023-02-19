#!/bin/bash

echo "Fan controll started"
gpio mode 7 out

while true
do
temperature=` cat /etc/armbianmonitor/datasources/soctemp`
# Верхний порог
if [ $temperature -gt 47000 ]; then
  echo "Fan ON"
  gpio write 7 1
fi;

# Нижний порог
if [ $temperature -lt 32000 ]; then
  echo "Fan OFF"
  gpio write 7 0
fi
sleep 3
done
