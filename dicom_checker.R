#
##
###
####
####### R Version: 4.2.0
####### Author: Holly Crowder
####### Purpose: Check the spreadsheet of spec data on Box against the expected values
#######          and return a list of the mistakes
####### Last Update: 2024-06-04
###################
library(readr)
library(tidyverse)
###################

#############
#import data#
#############

df2 <- read_csv("edited.csv", col_names = c("FolderName", "ID", "Date", "Scan", "SeriesDescription", "Size","X","Y","Z","Number_inst"), 
                                      col_types = cols(Date = col_date(format = "%Y-%m-%d")))

# List of expected scans
required_series_desc <- c("AAHead_Scout_64ch-head-coil", 
                          "Siemens_MPRAGE_ND",
                          "ep2d_3.2mm_2Back", 
                          "gre_field_mapping_2Back_ND")

today_date<- Sys.Date()
format(today_date, format = "%Y%m%d")
today_date<-as.character(today_date)

##########
#Funtions#
########## 
Function to check for missing series descriptions
check_series_desc <- function(df2, required_series_desc) {

  missing_df2 <- data.frame()

  # Iterate through unique IDs
  for (i in unique(df2$ID)) {
    subset_df <- df2[df2$ID == i, ]

    present_sd <- unique(subset_df$SeriesDescription)

    # Find missing series descriptions
    missing_sd <- setdiff(required_series_desc, present_sd)

    # Append missing series descriptions to missing_df2
    if (length(missing_sd) > 0) {
      missing_sd_rows <- data.frame(ID = rep(i, length(missing_sd)),
                                    SeriesDescription = missing_sd$SeriesDesc,
                                    stringsAsFactors = FALSE)
      missing_df2 <- rbind(missing_df2, missing_sd_rows)
    }
  }

  # Return the combined missing descriptions data frame
  return(missing_df2)
}

# check_correct_instances<- function(df2){
#   missing_inst_df<- data.frame()
#   
#   for (i in unique(df2$ID)) {
#     for (d in unique(df2$Date[df2$ID == i])) {
#       for (s in unique(df2$Scan[df2$ID == i & df2$Date == d])) {
#         for (sd in unique(df2$SeriesDescription[df2$ID == i & df2$Date == d & df2$Scan == s])) {
#            subset_df <- df2[df2$ID == i & df2$Date == d & df2$Scan == s & df2$SeriesDescription== sd,]
#       
#       # so basically im making a vector of the instances in this scan
#            present_slices <- (subset_df$X)
#            present_instances <- (subset_df$Number_inst)
#       # conditional statement here for the expected instances bc  they vary
#            
           expected_slices = case_when( grepl("Siemens_MPRAGE_ND", sd) ~ 176,
                                          grepl("Siemens_MPRAGE", sd) ~ 176,
                                          grepl("Siemens_MPRAGE_2x2x2", sd) ~ 176,
                                          grepl("Siemens_MPRAGE_2x2x2_ND", sd) ~ 176,
                                          grepl("ep2d_3.2mm_2Back", sd) ~ 64,
                                          grepl("gre_field_mapping_2Back_ND", sd) ~ 64,
                                          grepl("gre_field_mapping_2Back", sd) ~ 64)

          expected_instances = case_when(grepl("Siemens_MPRAGE_ND", sd) ~ 1,
                                        grepl("Siemens_MPRAGE", sd) ~ 1,
                                        grepl("Siemens_MPRAGE_2x2x2", sd) ~ 1,
                                        grepl("Siemens_MPRAGE_2x2x2_ND", sd) ~ 1,
                                        grepl("ep2d_3.2mm_2Back", sd) ~ 124,
                                        grepl("gre_field_mapping_2Back_ND", sd) ~ 1,
                                        grepl("gre_field_mapping_2Back", sd) ~ 1)
#         
#       
#           # BAM, set the diff of what's expected vs what we get. 
#           missing_instances <- setdiff(expected_instances, present_instances)
#           
#           if (length(missing_instances) > 0) {
#             missing_instances_rows <- data.frame(ID = rep(i, length(missing_instances)),
#                                                  Date = rep(d, length(missing_instances)),
#                                                  Scan = rep(s, length(missing_instances)),
#                                                  Instance = missing_instances,
#                                                  stringsAsFactors = FALSE)
#             missing_inst_df <- rbind(missing_inst_df, missing_instances_rows)
#       }
#     }
#     }
#    }
#   }
# # now i make sure i can get this data out of the loop
# return(missing_inst_df)
# }
# 
# missing_inst<-check_correct_instances(df2)