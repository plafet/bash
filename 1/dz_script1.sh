#!/bin/bash

# Определяем имя скрипта
SCRIPT_NAME=$(basename "$0")

# Файл для хранения PID
PID_FILE="./${SCRIPT_NAME}.pid"
### Need To Fix (NTF) Файлы с хранящимся пидом обычно называют название_скрипта.pid кроме того надо добавить такие файлы в gitignore, чтобы гит никогда не брал их в контроль. Так же там обычно указывают логи и т.п. вещи
function loop {
        while true; do
        sleep 2
        done
}

if [ ! -s "$PID_FILE" ]; then
    echo "файлик с PID пустой"
    echo $$ > "$PID_FILE"
    loop
else
    PID=`cat $PID_FILE`
    ### NTF переменные надо называть так, чтобы было понятно что в них хранится их названия. У тебя же понятно только то, что это переменная. Если там хранится пид, то пусть называется pid или PID например
    if [ `ps aux | grep $PID | awk '{print $2}' | head -n 1` -eq $PID ]; then
        echo "Такой PID уже запущен. магии не будет"
        exit 1
    else 
        echo "pid $$ отличается от того, что записан в файл. Ура магия!"
        echo $$ > "$PID_FILE"
        loop
    fi
fi 
