# Coursera Getting and Cleaning Data Project
This is the course project for the Coursera course Getting and Cleaning Data, instructed by Johns Hopkins University. An r script called `run_analysis.R` is created. 

Main functions of run_analysis.R are the following:
* Downloads the data and unzips it,
* Forms a main table with the whole data,
  - Measured values,
  - Subject numbers,
  - Activity status are combined for each train and test data, and these two sets are merged together,
* Extracts desired features from the data,
* Renames the features with more descriptive names,
* Renames the `activity` feature with more descriptive values,
* Finds the mean values of area of interest features and writes them on a .txt file.

The area of interest features are the ones that show the mean value or standard deviation of a variable. For every subject and activity combination, the mean values of these features are found and written on `tidy.txt`. The study is conducted on R version 3.4.3. Also note that the R package **reshape2** version 1.4.3. is used as well.
