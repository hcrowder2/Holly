#!/bin/bash
#written on bash version 3.2.57 

#Usage: creates folder structure for data exports for rda spec, twix spec, and DICOM
#Notes: See Project-Specific gDoc for full instructions on running this script
#Before 1st use on computer you need to modify permissions to allow this to run 
###   chmod +x /path/file
printf "System date is $(date +"%Y_%m_%d" ), creating folders for Striem-Amit Blindness project\n"

read -p 'Enter Subject ID: ' id

read -p 'Enter date in format YYYY_MM_DD (or t for today): ' input_date 

if [[ "$input_date" == "T" ||  "$input_date" == "t" ]]; then
        input_date=$(date +"%Y_%m_%d")
fi

lead="${id}_${input_date}"


f1="${lead}_1_GABA_V1_NWS"
f2="${lead}_2_GABA_V1_WS"
f3="${lead}_3_GABA_S1_NWS"
f4="${lead}_4_GABA_S1_WS"


i1="Instance_1_On"
i2="Instance_2_Off"
i3="Instance_3_Diff"



mkdir -pv "${lead}_rda_spec"/{"${f1}"/{"${f1}_${i1}","${f1}_${i2}","${f1}_${i3}"},"${f2}"/{"${f2}_${i1}","${f2}_${i2}","${f2}_${i3}"},"${f3}"/{"${f3}_${i1}","${f3}_${i2}","${f3}_${i3}"},"${f4}"/{"${f4}_${i1}","${f4}_${i2}","${f4}_${i3}"}}

chmod -R +rwx $PWD/"${lead}_rda_spec"/

mkdir -pv "${lead}" 
mkdir -pv "${lead}_twix_spec" 

chmod  +rwx $PWD/"${lead}_twix_spec"/
chmod  +rwx $PWD/"${lead}"/
