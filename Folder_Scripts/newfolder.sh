#!/bin/bash
#written on bash version 3.2.57 
#usage: create folders in any location with the executable newfolder 

echo "System date is $(date +"%Y_%m_%d" ), creating folders with format ID_YYYY_MM_DD"

while true; do
    
    read -p "Enter Subject ID: " id
    
    read -p "Enter date in format YYYY_MM_DD (or t for today):" input_date
    
    if [[ "$input_date" == "t" || "$input_date" == "T" ]]; then
        input_date=$(date +"%Y_%m_%d")
    fi

    lead="${id}_${input_date}" 

    mkdir -p "$lead" 
    chmod +rwx "$lead"

    read -p "Add another? (y/n):" more
    if [[ "$more" != "y" && "$more" != "t" ]] ;then
        break
    fi
done
echo "All done!"
