#!/bin/bash

#Usage: creates folder structure for data exports for rda spec, twix spec

read -p 'ID: ' ID

read -p 'Enter Date in format YYYY_MM_DD: ' Date 

lead="${ID}_${Date}"


F1="${lead}_1_GABA_V1_NWS"
F2="${lead}_2_GABA_V1_WS"
F3="${lead}_3_GABA_S1_NWS"
F4="${lead}_4_GABA_S1_WS"


I1="Instance_1_On"
I2="Instance_2_Off"
I3="Instance_3_Diff"



mkdir -pv "${lead}_rda_spec"/{"${F1}"/{"${F1}_${I1}","${F1}_${I2}","${F1}_${I3}"},"${F2}"/{"${F2}_${I1}","${F2}_${I2}","${F2}_${I3}"},"${F3}"/{"${F3}_${I1}","${F3}_${I2}","${F3}_${I3}"},"${F4}"/{"${F4}_${I1}","${F4}_${I2}","${F4}_${I3}"}



chmod -R +rwx $PWD/"${lead}_rda_spec"/

mkdir -pv "${lead}" 
mkdir -pv "${lead}_twix_spec" 

chmod  +rwx $PWD/"${lead}_twix_spec"/
chmod  +rwx $PWD/"${lead}"/