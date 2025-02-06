#!/bin/bash
#written on bash version 3.2.57 

#Usage: creates folder structure for data exports for rda spec, twix spec, twix BBB
###Also creates folders for start time of DICOM data folders using HH_MM format
#Notes: See Project-Specific gDoc for full instructions on running this script
#Before 1st use on computer you need to modify permissions to allow this to run 
###   chmod +rwx /path/file

printf "System date is $(date +"%Y_%m_%d" ), creating folders for Spence MWCCS project\n"

read -p 'Enter Subject ID: ' id

read -p 'Enter date in format YYYY_MM_DD (or t for today): ' input_date 


read -p 'Enter BILLING/MWCCS START TIME for in format HH_MM: ' start 
read -p 'Enter  START TIME for SPEC/ART/BBB in format HH_MM: ' art 

if [[ "$input_date" == "T" ||  "$input_date" == "t" ]]; then
        input_date=$(date +"%Y_%m_%d")
fi

lead="${id}_${input_date}"


F1="${lead}_1_FWM_WS"
F2="${lead}_2_FWM_NWS"
F3="${lead}_3_HIPP_WS"
F4="${lead}_4_HIPP_NWS"
F5="${lead}_5_Precuneus_WS"
F6="${lead}_6_Precuneus_NWS"



mkdir -pv "${lead}_rda_spec"/{"${F1}","${F2}","${F3}","${F4}","${F5}","${F6}"}


chmod -R +rwx $PWD/"${lead}_rda_spec"/

mkdir -pv "${lead}_${start}" 
mkdir -pv "${lead}_${art}" 
mkdir -pv "${lead}_twix_BBB" 
mkdir -pv "${lead}_twix_spec" 

chmod  +rwx $PWD/"${lead}_twix_BBB"/
chmod  +rwx $PWD/"${lead}_twix_spec"/
chmod  +rwx $PWD/"${lead}_${start}"/
chmod  +rwx $PWD/"${lead}_${art}"/

echo "#######################################################"  
echo "Remember that WS scans come before NWS in this protocol" 
echo "#######################################################"  
