#! /bin/bash
FILE=pass.txt
echo "Hello frind!
Let's register now"
read -p "Enter your name " name
read -s -p "Enter your password no less 4 characters " pass1
if [[ ${#pass1} -lt 4 ]]; then
    echo "less than 4 characters entered"
    exit 1
else  
    read -s -p "Repeat password " pass2
    if [[ $pass1 = $pass2 ]]; then
        PASS=`echo -n $pass1 | base64`
        echo "user created"
        #echo $PASS
        echo "$name $PASS" >> $FILE 
    else
        echo "Incorrected password"
        exit 1
    fi
fi
