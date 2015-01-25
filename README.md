# README.md for run_analysis.R

Getting the Data
----------------
The data for the script can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



Preparing data and running R script
-----------------------------------
1. Unzip the file into the folder "UCI HAR Dataset".
2. Open R Studio and set working directory to the folder where "UCI HAR Dataset" exist.
3. Open run_analysis.R and run.   
4. The result will be a tidy dataset created named final_avg.txt in the folder "UCI HAR 
Dataset".



R Script run_analysis.R processing steps
========================================
1. Set the working directory to "UCI HAR Dataset".

2. Read the following files into their own data frame.
   a) features.txt - this data provides the column names of the train and test data 
   b) activity_labels.txt - this data provides the Activity Code its Activity Name
   c) x_train.txt - this data provides quantitative measurements of the variables
   d) subject_train.txt - this data provided the subjects in the train dataset
   e) y_train.txt - this data provides the activity code of each observation
   f) x_test.txt - this data provides quantitative measurements of the variables
   g) subject_test.txt - this data provided the subjects in the test dataset
   h) y_test.txt - this data provides the activity code of each observation

3.  Change the column names of data frames with descriptive name and/or the provided names
in features.txt.

4. Get the column names that partially matches "std" or "mean" and use that to 
to subset x_train and y_test dataframe.

5. Combine all columns of all the data frames for the train datasets.

6. Combine all columns of all the data frames for the test datasets.

7. Combine all the rows of dataframes created in #5 and #6.  They should have exactly 
the same columns/variables.

8. Join the data frame in # 7 using common column "ActivityCode".  This will add the 
column ActivityName into the final data frame.

9. Get the average of each variable group by "ActivityName" and "SubjectNbr".  

10. The resulting data frame will have new group by columns.  Remove the original group by
columns and rename the new group by columns with "ActivityName" and "SubjectNbr". 

11. Write the tidy data set into the file final_avg.txt
