#!/bin/bash
#written on bash version 3.2.57 

#Usage: creates folder structure for data exports for rda spec, twix spec, twix BBB
#Notes: See Project-Specific gDoc for full instructions on running this script
#Before 1st use on computer you need to modify permissions to allow this to run 
###   chmod +rwx /path/file
printf "System date is $(date +"%Y_%m_%d" ), creating folders for Holton GWI project\n"

read -p 'Enter Subject ID: ' id

read -p 'Enter Date in format YYYY_MM_DD (or t for today): ' input_date 

if [[ "$input_date" == "T" ||  "$input_date" == "t" ]]; then
        input_date=$(date +"%Y_%m_%d")
fi

lead="${id}_${input_date}"


F1="${lead}_1_GABA_DLPFC_NWS"
F2="${lead}_2_GABA_DLPFC_WS"
F3="${lead}_3_GABA_V1_NWS"
F4="${lead}_4_GABA_V1_WS"
F5="${lead}_5_GABA_PCU_NWS"
F6="${lead}_6_GABA_PCU_WS"
F7="${lead}_7_HERC_PCU_NWS"
F8="${lead}_8_HERC_PCU_WS"

I1="Instance_1_On"
I2="Instance_2_Off"
I3="Instance_3_Diff"



mkdir -pv "${lead}_rda_spec"/{"${F1}"/{"${F1}_${I1}","${F1}_${I2}","${F1}_${I3}"},"${F2}"/{"${F2}_${I1}","${F2}_${I2}","${F2}_${I3}"},"${F3}"/{"${F3}_${I1}","${F3}_${I2}","${F3}_${I3}"},"${F4}"/{"${F4}_${I1}","${F4}_${I2}","${F4}_${I3}"},"${F5}"/{"${F5}_${I1}","${F5}_${I2}","${F5}_${I3}"},"${F6}"/{"${F6}_${I1}","${F6}_${I2}","${F6}_${I3}"},"${F7}","${F8}"}



chmod -R +rwx $PWD/"${lead}_rda_spec"/

mkdir -pv "${lead}" 
mkdir -pv "${lead}_twix_BBB" 
mkdir -pv "${lead}_twix_spec" 

chmod  +rwx $PWD/"${lead}_twix_BBB"/
chmod  +rwx $PWD/"${lead}_twix_spec"/
chmod  +rwx $PWD/"${lead}"/

printf "All done!\nPlease inspect folders and make adjustments as needed to fit the participant's session!"
