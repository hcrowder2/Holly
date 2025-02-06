#!/bin/bash

#Usage: creates folder structure for data exports for rda spec, twix spec, twix BBB
#Also creates folders for start time of DICOM data folders using HH_MM format

read -p 'ID: ' ID

read -p 'Enter Date in format YYYY_MM_DD: ' Date 
read -p 'Enter BILLING/MWCCS START TIME for in format HH_MM: ' START 
read -p 'Enter  START TIME for SPEC/ART in format HH_MM: ' ART 


lead="${ID}_${Date}"


F1="${lead}_1_FWM_WS"
F2="${lead}_2_FWM_NWS"
F3="${lead}_3_HIPP_WS"
F4="${lead}_4_HIPP_NWS"
F5="${lead}_5_Precuneus_WS"
F6="${lead}_6_Precuneus_NWS"



mkdir -pv "${lead}_rda_spec"/{"${F1}","${F2}","${F3}","${F4}","${F5}","${F6}"}


chmod -R +rwx $PWD/"${lead}_rda_spec"/

mkdir -pv "${lead}_${START}" 
mkdir -pv "${lead}_${ART}" 
mkdir -pv "${lead}_twix_BBB" 
mkdir -pv "${lead}_twix_spec" 

chmod  +rwx $PWD/"${lead}_twix_BBB"/
chmod  +rwx $PWD/"${lead}_twix_spec"/
chmod  +rwx $PWD/"${lead}_${START}"/
chmod  +rwx $PWD/"${lead}_${ART}"/

echo "#######################################################"  
echo "Remember that WS scans come before NWS in this protocol" 
echo "#######################################################"  
