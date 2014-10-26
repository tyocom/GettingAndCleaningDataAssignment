GettingAndCleaningDataAssignment
================================

The script assumes that the user has changed the working directory to the location where the zip file has been unzipped (the directory containing the "UCI HAR Dataset directory).  All of the paths are relative from there.  

To run, put the script file in the working directory and execute the command:

source ("run_analysis.R")

Two dataframes are created.  The first is named df and contains the results from the test and training sets with the activity and subject labels plus the mean and std of the various measurements.   The second is named dftidy and contains the mean of the measuremnts per subject and activity.

