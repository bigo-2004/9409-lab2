#!/bin/sh

dir=$1
quarantine=$2

echo "Src Directory: $dir"
echo "Quarantine Folder: $quarantine"


while true
do
    count=0

    for file in "$quarantine"/*
    do
        [ -e "$file" ] || continue #if no files, skip the loop before incrementing count!
        count=`expr "$count" + 1`
        echo "$count) ${file##*/}"
    done

    if [ "$count" -eq 0 ]
    then
        echo "No malicious files to review."
        break
    fi

    echo "Choose a file number from (1 to $count) (0 to exit):"
    read choice

case "$choice" in
    0)
        echo "Exiting..."
        break
        ;;
    ''|*[!0-9]*)
        echo "Invalid choice!!"
        continue
        ;;
esac
    if [ "$choice" -lt 1 ] || [ "$choice" -gt "$count" ] 2>/dev/null
    then
        echo "Invalid choice!!"
        continue
    fi

    selected=0
    #to select the file matching the user's choice
    for file in "$quarantine"/*
    do
        [ -e "$file" ] || continue
        selected=`expr "$selected" + 1`

        if [ "$selected" -eq "$choice" ]
        then
            break
        fi
    done

    echo "1. Restore"
    echo "2. Permanently delete"
    echo "3. Leave as-is"
    read action

    case "$action" in
        1)
            filename=${file##*/}
            mv "$file" "$dir/"
            echo "Restored $filename to $dir."
            ;;
        2)
            filename=${file##*/}
            rm "$file"
            echo "$filename permanently deleted."
            ;;
        3)
            echo "Leaving file as-is"
            ;;
        *)
            echo "Invalid action"
            ;;
    esac

done