#! /bin/bash

#set -euo pipefail
FILE=pum.txt

usage() {
    cat <<EOF
Usage: $0 [OPTIONS] <argument>

Options:
  -n, set a name appender
  -l, set level log
  -c, category log
  -i, interactive mode 
  -h, show this help message

Example:
  $0 -n account_manager -l info -c provider.log 
EOF
exit 1
}
error() {
    cat <<EOF
Incorrect enter
EOF
usage
    }

#while true; do
#arg=$*
if [[ -n $1 ]]; then
for  arg in $*; do
    case $arg in
        -n) 
            shift
            if [[ -n $1 ]]; then
                NEW_LOG_NAME=`echo ${1} | tr '[:lower:]' '[:upper:]'`
                #echo "$NEW_LOG_NAME"
                shift
            else
                echo "Value can't be empty"
                usage
             fi   
            ;;
        -l)
            shift
            if [[ -n $1 ]]; then
                NEW_LOG_LEVEL=$1
                #echo "$NEW_LOG_LEVEL"
                shift
            else
                echo "Value can't be empty"
                usage
            fi
            ;;
        -c)
            shift
            if [[ -n $1 ]]; then
                NEW_LOG_CATEGORY=$1
                #echo "$NEW_LOG_CATEGORY"
                shift
            else
                echo "Value can't be empty"
                usage
            fi
            ;;
        -i)
            echo "Welcome to interactive mode!"
            while true; do
            read -p "Enter new log name: " NEW_LOG_NAME
            if [[ -n $NEW_LOG_NAME ]]; then
                read -p "Enter new log category: " NEW_LOG_CATEGORY
                if [[ -n $NEW_LOG_CATEGORY ]]; then
                    read -p "Enter new log level: " NEW_LOG_LEVEL
                    if [[ -n $NEW_LOG_LEVEL ]]; then
                    echo "Good! Logger write"
                    break
                    else
                        echo "Values can't be empty"
                    fi
                else
                    echo "Values can't be empty"
                fi
            else
                echo "Values can't be empty"
            fi
            done
            ;;
        -h) 
            usage
            ;;
         -*)   
            error
    esac
done
else
    error
fi

new_log_name=$(echo $NEW_LOG_NAME | tr '[:upper:]' '[:lower:]')
str1='    <appender name="'
str2='" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>${logPrefix}/'
str3='</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>${logPrefix}/old/'
str4='.%d{"yyyy-MM-dd-HH" GMT}.log</fileNamePattern>
        </rollingPolicy>
        <encoder>
            <pattern>${DEFAULT_PATTERN}</pattern>
        </encoder>
    </appender>
'
str5='
    <appender name="'
str6='" class="ch.qos.logback.classic.AsyncAppender">'
str7='
        <appender-ref ref="'
str8='"/>
    </appender>
'
str9='
    <logger name="'
str10='" level="'
str11='">
        <appender-ref ref="'
str12='"/>
    </logger>'

echo "${str1}${NEW_LOG_NAME%.*}_FILE${str2}${new_log_name}${str3}${new_log_name%.*}${str4}${str5}${NEW_LOG_NAME%.*}_ROLL${str6}${str7}${NEW_LOG_NAME%.*}_FILE${str8}${str9}${NEW_LOG_CATEGORY}${str10}${NEW_LOG_LEVEL}${str11}${NEW_LOG_NAME%.*}_ROLL${str12}"
