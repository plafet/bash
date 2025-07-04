#! /bin/bash

FILE=pass.txt
declare -A USER

register() {
declare -A USER

if ! [[ -e $FILE ]]; then
    touch $FILE
fi

while true; do
    echo "Enter your name:"
    read -r name  
    USER["user"]=$name
    if [[ -z ${USER[user]} ]]; then
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
    read -s password
    USER["pass"]=$password
    temp_pass=`echo -n ${USER["pass"]}`
    if [[ ${#temp_pass} -lt 4 ]]; then
        echo "Less than 4 characters entered"
    else
        echo "Repeat password: "
        read -s check_password
        USER["pass_chk"]=$check_password
        if [[ ${USER[pass]} = ${USER[pass_chk]} ]]; then
            PASS=`echo -n ${USER["pass"]}| base64`
            echo "User created!"
            echo "${USER["user"]} $PASS" >> $FILE
            break
        else
            echo "No match password. Try again"
        fi
    fi
done
}

login() {
while true; do
    echo "Enter your name: "
    read -r name
    USER["login"]=$name
    if [[ -z ${USER[login]} ]]; then
    echo "Name cannot be empty. Try again."
    continue
    fi

    if grep -q ${USER["login"]} $FILE; then
        echo "Please enter password for ${USER["login"]}: "
        read -s password
        if [[ `grep "^${USER["login"]}" "$FILE" | awk '{print $2}' | base64 -d` = $password ]]; then
            echo "Welcome!"
            break
        else
            echo "Wrong password. Try again"
            sleep 1
        fi
    else
        echo "user ${USER["login"]} does not exist"
        break
    fi
done
}

while true; do
echo "Hello friend! You are registered? Please enter Y or N to continue"
read check
if [[ $check = Y ]]; then
    register
    break
elif [[ $check = N ]]; then
    login
    break
else 
    echo "Wrong enter. Try again"
fi
done    
