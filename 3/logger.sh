#! /bin/bash

NEW_LOG_NAME=`echo $1 | tr '[:lower:]' '[:upper:]'`
NEW_LOG_CATEGORY=$2
NEW_LOG_LEVEL=`echo $3 | tr '[:lower:]' '[:upper:]'`
APPENDER=$(echo $NEW_LOG_NAME|cut -f 1 -d'.' )

P1='    <appender name="'
P2='" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>${logPrefix}/'
P3='</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>${logPrefix}/old/'
P99='.%d{"yyyy-MM-dd-HH" GMT}.log</fileNamePattern>
        </rollingPolicy>
        <encoder>
            <pattern>${DEFAULT_PATTERN}</pattern>
        </encoder>
    </appender>
'
P4='
    <appender name="'
P5='" class="ch.qos.logback.classic.AsyncAppender">'
P6='
        <appender-ref ref="'
P7='"/>
    </appender>
'
P8='
    <logger name="'
P9='" level="'
P10='">
        <appender-ref ref="'
P11='"/>
    </logger>'




if [[ "$#" -lt 3 ]]; then
    echo "You must specify three arguments in the following sequence: 1 - log name 2 - log category 3 - log level"
    exit 1
fi

#echo $NEW_LOG_NAME $NEW_LOG_CATEGORY $NEW_LOG_LEVEL $APPENDER

echo "${P1}${APPENDER}_FILE${P2}${1}${P3}${1%.*}${P99}${P4}${APPENDER}_ROLL${P5}${P6}${APPENDER}_FILE${P7}${P8}${NEW_LOG_CATEGORY}${P9}${NEW_LOG_LEVEL}${P10}${APPENDER}_ROLL${P11}"

#function character_conversions { 
#OLD_LOG_NAME=`grep "_FILE" text.txt | awk -F '"' 'NR==1{print $2}'`
#OLD_LOG_NAME_ASYNC=`grep "Async" text.txt | awk -F '"' '{print $2}'`
#OLD_LOG_CATEGORY=`grep "level=" text.txt | awk -F '"' '{print $2}'`
#OLD_LOG_LEVEL=`grep "level=" text.txt | awk -F '"' '{print $4}'`


#sed -i "s/$OLD_LOG_NAME/${NEW_LOG_NAME%.*}\_FILE/g" text.txt
#sed -i "s/$OLD_LOG_NAME_ASYNC/${NEW_LOG_NAME%.*}\_ROLL/g" text.txt
#sed -i "s/$OLD_LOG_LEVEL/$NEW_LOG_LEVEL/g" text.txt
#sed -i "s/$OLD_LOG_CATEGORY/$NEW_LOG_CATEGORY/g" text.txt
#cat text.txt 
