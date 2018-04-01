# Code Book
## 1. Getting Data
This is the code book that explains the variables and transformations. The used data is the collected data by accelerometers of Samsung Galaxy S Smartphone. The raw data can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) whereas the full description for data is available on the [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) that the data is obtained. The `run_analysis.r` makes a series of operations on these data and gives and output called `tidy.txt`. This file shows the average value of each area of interest feature for each subject number - activity combination. Area of interest features, their descriptions, and the conducted transformations are explained below.

## 2. Forming Data set
The obtained study divides the data into two groups for training and testing purposes. In this study, these groups are merged together. Two main processes are done before the merging operation.

### 2.1. Extraction of Features
The project asks for the mean values and standard deviations of measures. Therefore, the features that contain mean() and std() in their name are extracted. meanFreq description stand for weighted average, so the ones with that property are not considered as an area of interest variable. After finding which columns store such features, subsetting is applied on test and train sets to extract these columns.

To make the names more clear, characters "-", "(", and ")" are deleted from variable names. *mean* and *std* are rewritten as *Mean* and *Std*. Every variable name starts with a *t* or *f* that specifies the measurement domain; these are transformed to *Time* or *Freq* to make it more understandable.

### 2.2. Adding Subject Number and Activity Columns
First, the subject numbers for an observation is added, and then the activity status for that is added to the test and train sets. These two sets are combined after these additions are made. The column showing the subject number is called *subjectno* and the one that shows the activity status is the *activity* column. These two variables can be regarded as identifiers. Note that they are converted to factor variables.

## 3. Variables
### 3.1. Identifiers
* subjectno: Identifies the subject who performed the activity for the given window sample. Takes values from 1 to 30.
* activity: Identifies the activity name. The raw data takes values between 1-6, but they are converted as:

| Original Label        | Transformed Label           |
| ------------- |:------------------:| 
| 1             | walking                             |
| 2             | walking_upstaris                    |
| 3             | walking_downstaris                  |
| 4             | sitting                             |
| 5             | standing                            |
| 6             | laying                              |

### 3.2. Measured Variables
First of all, it is given that all measured are normalized into [-1 ,1] range. Further information on the measurements are present on `features_info.txt` file in the original folder. Variable names are formed by a combination of their properties.

* domain of the measurement: "Time", if the domain signal is time; "Freq" if it is frequency.
* acceleration signal separation: "Body" for body accelaration signals; "Gravity" for gravity accelaration signals. "BodyBody" variables are turned into "Body" as it looks like typo.
* raw signal source: "Gyro" if gryroscope; "Acc" if accelerometer.
* jerk signal usage: "Jerk", if jerk signal is obtained; nothing, otherwise.
* magnitudes: "Mag", if magnitudes of signal are calculated; nothing, otherwise.
* summary statistic: "Mean", if it shows the mean value; "Std" for standard deviation.
* axis: A complementary name comes after "Axis" property. It denotes the direction of the signal.
