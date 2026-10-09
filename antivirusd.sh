#!/bin/sh

echo "Malicious Directory : $1"
echo "Quarantine Folder: $2"
echo "Interval (secs): $3"

dir=$1
quarantine=$2

scan_dir(){
        for file in "$dir"/*
        do
            echo "Checking: $file"
            is_malicious=0
            case "$file" in *.exe|*.bat|*.vbs|*.scr|*.ps1)
                    
            echo "$file has a malicious extension"
            is_malicious=1
            ;;
            *)
            
            ;;
            esac

            grep -qiE 'virus|trojan|malware|worm|ransomware' "$file"
            if [ $? -eq 0 ]
            then
                echo "$file contains malicious content"
                is_malicious=1
          
            fi

            if [ $is_malicious -eq 1 ]
            then
                echo "$file is malicious and it is DELETED"
                cp "$file" "$quarantine"
                rm "$file"
            else
                echo "$file is safe"
            fi
    

        done
}

if [ -e "directory-info-last.txt" ] 
then
    echo "Running"
else
 echo "First Run"
 scan_dir
 ls -l "$dir" > directory-info-last.txt 
fi



while true
do
    sleep "$3"

    ls -l "$dir" > directory-info-new.txt

    diff -q directory-info-last.txt directory-info-new.txt > /dev/null
    status=$?

    if [ $status -eq 0 ]
    then
        echo "No changes detected"
    elif [ $status -eq 1 ]
    then
        echo "Changes detected"


        scan_dir
        

        cp directory-info-new.txt directory-info-last.txt
    fi
done