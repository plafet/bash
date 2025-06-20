#!/bin/sh

# Определяем имя скрипта
SCRIPT_NAME=$(basename "$0")

# Файл для хранения PID
PID_FILE="./pid.${SCRIPT_NAME}"

if [ ! -f "$PID_FILE" ]; then
    echo "процесс с таким PID звпущен"    
# записали номер pid в файл
echo "файла с PID нет. Значит создадим и запустим скрипт" 
echo $$ > "$PID_FILE"
while true; do
sleep 2
done
#if [[ echo $PID_FILE == $$ ]]; then 
else echo "файл с PID уже есть"
#else echo "файл с PID уже есть. Значит проверим, есть ли в списке процесс с таким PID"
#echo "процесс с таким PID звпущен"
fi
#fi
