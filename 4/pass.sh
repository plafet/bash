#! /bin/bash
FILE=pass.txt
if ! [[ -e $FILE ]]; then
    touch $FILE
fi

echo "Hello frind! Let's register now"

while true; do
    read -p "Enter your name: " name
    if [[ -z "$name" ]]; then
        echo "Name cannot be empty. Try again."
        continue
    fi

    if grep -q $name $FILE; then
        echo "This name already exists. Enter another name"
    else
        break
    fi
done

while true; do
    echo "Enter your password no less 4 characters: "
    read -s pass1
    if [[ ${#pass1} -lt 4 ]]; then
        echo "Less than 4 characters entered"
    else
        echo "Repeat password: "
        read -s pass2
        if [[ $pass1 = $pass2 ]]; then
            PASS=`echo -n $pass1 | base64`
            echo "User created!"
            echo "$name $PASS" >> $FILE
            break
        else
            echo "No match password. Try again"
        fi
    fi
done
