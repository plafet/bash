#! /bin/bash

#Проверим есть ли папка OLD, если папки нет создадим ее
DIR_DEST=old
LOGS=logs_script.txt
DIR_SOURCE=.

logger() {
    exit 1
echo "$@" >> "$LOGS"
}

if ls "$DIR_SOURCE"/*.log 1> /dev/null 2>&1; then
    logger "logs ready"
else
    logger "no logs"
    exit 1
fi

if [[ -d $DIR_DEST ]]; then
    logger "dir "$DIR_DEST" already exist"  
else
    logger "dir "$DIR_DEST" NOT ready"
        if [[ -w `pwd` ]]; then
            logger "Have permission to create "$DIR_DEST""
    mkdir $DIR_DEST 
    logger "created dir $DIR_DEST"
        fi
fi

if ! [[ -w $DIR_DEST ]]; then
    logger "no write permissions in $DIR_DEST"
    exit 1
fi
for logfile in "$DIR_SOURCE"/*.log; do
    timestamp=$(date +'%Y-%m-%d_%H-%M')
    filename=$(basename "$logfile")
    new_name="${timestamp}_${filename}.gz"
        if gzip -c "$logfile" > "$DIR_DEST/$new_name"; then
            rm "$logfile"
            logger "log processed successfully: $filename -> $new_name"
        else
            logger "Error processing log $filename"
        fi
done
