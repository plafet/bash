#! /bin/bash

if [[ "$#" -lt 3 ]]; then
    echo "You must specify three arguments in the following sequence: 1 - log name 2 - log category 3 - log level"
    exit 1
fi

#function character_conversions { 
OLD_LOG_NAME=`grep "_FILE" text.txt | awk -F '"' 'NR==1{print $2}'`
OLD_LOG_NAME_ASYNC=`grep "Async" text.txt | awk -F '"' '{print $2}'`
OLD_LOG_CATEGORY=`grep "level=" text.txt | awk -F '"' '{print $2}'`
OLD_LOG_LEVEL=`grep "level=" text.txt | awk -F '"' '{print $4}'`

NEW_LOG_NAME=`echo $1 | tr '[:lower:]' '[:upper:]'`
NEW_LOG_CATEGORY=$2
NEW_LOG_LEVEL=`echo $3 | tr '[:lower:]' '[:upper:]'`

sed -i "s/$OLD_LOG_NAME/${NEW_LOG_NAME%.*}\_FILE/g" text.txt
sed -i "s/$OLD_LOG_NAME_ASYNC/${NEW_LOG_NAME%.*}\_ROLL/g" text.txt
sed -i "s/$OLD_LOG_LEVEL/$NEW_LOG_LEVEL/g" text.txt
sed -i "s/$OLD_LOG_CATEGORY/$NEW_LOG_CATEGORY/g" text.txt
cat text.txt 
