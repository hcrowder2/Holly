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
df <- read_delim("BoxSpec.txt", 
                 delim = "\t", escape_double = FALSE, 
                 col_names = FALSE, col_types = cols(X2 = col_character(), 
                                                     X4 = col_character()), trim_ws = TRUE)
View(df)

colnames(df)[1:4] <- c("ID", "Date", "Scan", "Instance")

datalog<-DataLog_2024_06_24 <- read_csv("DataLog_2024_06_24.csv", 
                               col_types = cols(`Date of Scan` = col_date(format = "%m/%d/%Y")))
datalog<- datalog[,1:2]
colnames(datalog)[1:2] <- c("Date","ID")
datalog$Date<-format(datalog$Date, format = "%Y%m%d")

###############
#set variables#
###############

# List of expected scans
expected_scans <- c("svs_edit_L_dLPFC_GABA_NWS_2.6mm3","svs_edit_L_dLPFC_GABA_WS_2.6mm3",
           "svs_edit_R_Vis_GABA_NWS_2.5mm3","svs_edit_R_Vis_GABA_WS_2.5mm3",
           "svs_edit_L_Prec_GABA_NWS_2.6mm2", "svs_edit_L_Prec_GABA_WS_2.6mm2",   
           "smm_svs_herc_Prec_WS", "smm_svs_herc_Prec_NWS")

today_date<- Sys.Date()
format(today_date, format = "%Y%m%d")
today_date<-as.character(today_date)

###########
#Functions#
###########

`%nin%` = Negate(`%in%`)


#FunctionnnnnTime-- This is to check for the missing instances and export a df of it
check_instances <- function(df, expected_scans) {
  missing_df <- data.frame(ID = character(),
                           Date = character(),
                           Scan = character(),
                           Instance = character(),
                           stringsAsFactors = FALSE)
  
  all_instances_present <- TRUE
  
  #I was just recently talking to someone about how I never use for loops in R 
  #but here I am, also can you tell ive been writing in bash? 

  #the useful comment here is that this is going to nest my for-loops to circle 
  #through and check each scan of each date of each participant against the expected scans
  #and instances. 
  
  for (i in unique(df$ID)) {
    for (d in unique(df$Date[df$ID == i])) {
      for (s in expected_scans) {
        subset_df <- df[df$ID == i & df$Date == d & df$Scan == s, ]
        
        # so basically im making a vector of the instances in this scan
        present_instances <- unique(subset_df$Instance)
        
        # conditional statement here for the expected instances bc herc only has one instance
        if (grepl("smm_svs_herc_Prec_", s)) {
          expected_instances <- 1  
        } else {
          expected_instances <- 1:3  
        }
        
        # BAM, set the diff of what's expected vs what we get. 
        missing_instances <- setdiff(expected_instances, present_instances)
        # now im appending to my dataframe. i have no idea why i needed rbind i dont use forloops often 
        if (length(missing_instances) > 0) {
          missing_instances_rows <- data.frame(ID = rep(i, length(missing_instances)),
                                     Date = rep(d, length(missing_instances)),
                                     Scan = rep(s, length(missing_instances)),
                                     Instance = missing_instances,
                                     stringsAsFactors = FALSE)
          missing_df <- rbind(missing_df, missing_instances_rows)
          all_instances_present <- FALSE #this is redundant rn but whatevs 
        }
      }
    }
  }
  
  # now i make sure i can get this data out of the loop
  return(missing_df)
}


###########Heres where I do the things################
duplicate_scans<-  df %>%
  filter(duplicated(df,fromLast=FALSE))

# make our df of the missing instances 
missing_instances_to_print <- check_instances(df, expected_scans)
missing_instances_to_print <- missing_instances_to_print %>% arrange(ID, Date, Scan, Instance)

#df of correct IDs
allIDses <- select(df, ID, Date)
allIDses$ID_Date <- paste0(df$ID,"_", df$Date)
MissingIDs <- select(missing_instances_to_print, ID, Date)
MissingIDs$ID_Date <- paste0(missing_instances_to_print$ID,"_",missing_instances_to_print$Date)
DuplicateIDs <- select(duplicate_scans, ID, Date)
DuplicateIDs$ID_Date <- paste0(duplicate_scans$ID,"_",duplicate_scans$Date)
AllErrorIDs <- rbind(MissingIDs,DuplicateIDs)
datalog$ID_Date <- paste0(datalog$ID,"_",datalog$Date)

correctIDs <- allIDses %>%
  filter(ID_Date %nin% AllErrorIDs$ID_Date)

correctIDs<- unique(correctIDs)

correctIDs_AlsoMatchExpectedDates<- correctIDs %>%
  filter(ID_Date %in% datalog$ID_Date)

# Export the  dataframe as a CSV -- id like to use a variable to add todays date to the title.
write.csv(missing_instances_to_print, paste0("missing_spec_instances","_",today_date,".csv"))
write.csv(duplicate_scans, paste0("duplicate_spec_instances","_",today_date,".csv"))
write.csv(correctIDs_AlsoMatchExpectedDates, paste0("CorrectIDs","_",today_date,".csv"))
write.csv(missing_instances_to_print, paste0("missing_spec_instances","_",today_date,".csv"))
