# Overview
This README file explains in high level terms how we get from the dataset containing accelerometer and gyroscope raw signals to the tidy data set described in the CODEBOOK markdown file contained in this repo.  
# Assumptions
* The *UCI HAR Dataset* folder containing the raw data is contained in the same folder as the *run_analysis.R* script.  
# Data Transformation Steps
1.  Download the dataset from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2.  Unzip the dataset. This will create the *UCI HAR Dataset* folder.
3.  Execute the *run_analysis.R* script from the same folder containing the dataset.
4.  The tidy output dataset will be contained in a file named *outputData.txt* in the same folder.  
# Script Description
The script *run_analysis.R* simply stitches together data from the raw dataset and transforms the data into a tidy data set as described in the CODEBOOK markdown file.The steps this script takes are:
1. Reads the applicable data from the files into objects.
2. Combines all the relevant data into a single data frame.
3. Renames the variable names (column names) per the descriptions supplied in the dataset, in addition to new names for the subject and activity variables.
4. Filters the data frame so that it only includes variables that are means or standard deviations (86 in total, in addition to the subject and activity variables)
5. Aggregates the data frame to compute the mean for each combination of subject and activity and tidies up the data a bit after that aggregation.
6. Changes the activity IDs in the activity variable to be more human readable based on the mapping given in the data set.
7. Writes the output to a text file.