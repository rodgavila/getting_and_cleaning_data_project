# Getting and Cleaning Data Final Project (By Rodrigo Gomez Avila)

## Summary
This repro contains the source code for the final project, as well as the the Cookbook of the variables. **Note that althought this repro contains source code for a solution, it does not violate Coursera guidelines, given that it was explicitely requested by the course assignment**

## Contents
* README.md (This file)
* run_analysis.R (Source code)
* Cookbok.pdf (Cookbook containing variable descriptions)

## Instructions
1. Download the ZIP file containing the Samsung data set to your computer
2. Extract the contents of the ZIP file to a folder named /data/UCI_HAR_Dataset under your R working directory
3. Run the generate_tidy_set() function, it will return the tidy set

## High level overview
This is what the run_analysis.R does at a high level
1. Load the data from data/UCI_HAR_Dataset
2. Combines test and train data for features, activities, and subjects
3. Merges the combined data from the previous step into a single frame
4. Renames the data frame column names to the appropriate variables names from *features.txt*
5. Selects only subject, activity, mean and standard deviation variables
6. It changes the activity variable from activity id to activity label based on *activity_labels.txt*
7. It renames the column names based to conform to the R naming scheme by using the *fix_col_names()* function
8. Finally, it generates a new data frame that contains an aggregation by subject and activity
