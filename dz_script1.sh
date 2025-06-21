#!/bin/sh

# Определяем имя скрипта
SCRIPT_NAME=$(basename "$0")

# Файл для хранения PID
PID_FILE="./pid_${SCRIPT_NAME}"

if [ ! -s "$PID_FILE" ]; then
    echo "файлик с PID пустой"
    echo $$ > "$PID_FILE"
    while true; do
    sleep 2
    done
    else 
        var=`cat $PID_FILE`
        if [ `ps aux | grep $var | awk '{print $2}' | head -n 1` -eq `cat $PID_FILE` ]; then
        echo "Такой PID уже запущен. магии не будет"
        exit 1
        else 
        echo "pid $$ отличается от того, что записан в файл. Ура магия!"
        echo $$ > "$PID_FILE"
        while true; do
        sleep 2
        done
        fi
fi 
