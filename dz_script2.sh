#! /bin/bash

#Проверим есть ли папка OLD, если папки нет создадим ее

dir=~/lesson/lesson1/bash/rotate/old
logs=logs_script.txt
source_dir=~/lesson/lesson1/bash/rotate

if [[ -d $dir ]]; then
    echo "dir $dir is ready" >> $logs  
else
    echo "dir $dir NOT ready" >> $logs
    mkdir $dir 
    echo "create dir $dir" >> $logs
fi

#проверим есть ли права на добавление файлов в папку
if [[ -w $dir ]]; then
    echo "dir $dir is writable" >> $logs
    #основная часть работы с файлами
    for logfile in "$source_dir"/*.log; do
    timestamp=$(date +'%Y-%m-%d_%H-%M')
    filename=$(basename "$logfile")
    new_name="${timestamp}_${filename}.gz"
        if gzip -c "$logfile" > "$dir/$new_name"; then
            rm "$logfile"
            echo "Успешно обработан: $filename -> $new_name" >> $logs
        else
            echo "Ошибка при обработке файла $filename" >> $logs
        fi
    done    
else 
    echo "no write permissions in $dir" >> $logs
    exit 1
fi
