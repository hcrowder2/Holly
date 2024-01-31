#!/bin/bash

read -p 'ID: ' ID

read -p 'Enter Date in format YYYY_MM_DD: ' Date 

lead="${ID}_${Date}"


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



mkdir -pv "${lead}_spec"/{"${F1}"/{"${F1}_${I1}","${F1}_${I2}","${F1}_${I3}"},"${F2}"/{"${F2}_${I1}","${F2}_${I2}","${F2}_${I3}"},"${F3}"/{"${F3}_${I1}","${F3}_${I2}","${F3}_${I3}"},"${F4}"/{"${F4}_${I1}","${F4}_${I2}","${F4}_${I3}"},"${F5}"/{"${F5}_${I1}","${F5}_${I2}","${F5}_${I3}"},"${F6}"/{"${F6}_${I1}","${F6}_${I2}","${F6}_${I3}"},"${F7}","${F8}"}



chmod -R +rwx $PWD/"${lead}_spec"/

mkdir -pv "${lead}" 
mkdir -pv "${lead}_BBB" 
mkdir -pv "${lead}_twix" 

chmod  +rwx $PWD/"${lead}_BBB"/
chmod  +rwx $PWD/"${lead}_twix"/
chmod  +rwx $PWD/"${lead}"/