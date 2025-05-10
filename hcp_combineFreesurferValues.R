# Author: Alana Muller (alana.m@wustl.edu)
# Heavy use of ChatGPT as a disclaimer
# Description: Combine freesurfer values for Human Connectome Project
# into one excel file to do more analyses in R!
# Date created: May 9, 2025

# HCP-Aging: 725
# HCP-Development: 652

# Clear environment
rm(list = ls())

# Packages

setwd("C:/Users/alana.m/Box/Head Research Laboratory/Project_Inverse/HCP_Freesurfer_Complete/FreesurferFiles_Aging/Package_1211876/fmriresults01")

##### List all the aseg.stats.txt files that need to be opened (one for each subject)

# C:/Users/alana.m/Box/Head Research Laboratory/Project_Inverse/HCP_Freesurfer_Complete/FreesurferFiles_Aging/Package_1211876/fmriresults01
# C:/Users/alana.m/Box/Alana workspace/test

files_list <- list.files(path = "C:/Users/alana.m/Box/Head Research Laboratory/Project_Inverse/HCP_Freesurfer_Complete/FreesurferFiles_Aging/Package_1211876/fmriresults01", 
           pattern = "^aseg\\.stats$", 
           recursive = TRUE, full.names = TRUE)

# Initialize a table to put data into
subject_table <- data.frame(
  subject_id = character(),
  eTIV_mm3 = numeric()
)

# Loop through each participant to get their subject_ID and eTIV (Estimated Total Intracranial Volume)
for (i in 1:length(files_list)) {
  
  # Read the contents of the first file
  current_lines <- readLines(files_list[i])
  
  # Find the line that starts with "# subjectname"
  subject_line <- grep("^# subjectname", current_lines, value = TRUE)
  
  # Extract the ID using a regular expression
  subject_id <- sub("^# subjectname\\s+", "", subject_line)
  
  # Find the line that has eTIV
  etiv_line <- grep("^# Measure EstimatedTotalIntraCranialVol", current_lines, value = TRUE)
  
  # Extract the eTIV number
  etiv_value <- sub(".*,\\s*([0-9.]+),\\s*mm\\^3$", "\\1", etiv_line)
  
  # Add values to subject_table
  subject_table[i,1] <- subject_id
  subject_table[i,2] <- etiv_value
  
  # Print to check status
  print(cat("Done with ", subject_id))

}




