# Getting and Cleaning Data Course Project

## Files Contained

* `CodeBook.md` describes the variables & data at `tidy.txt` file. [CodeBook.md in this repo](https://github.com/maxaldunate/getting-and-cleaning-data-course-project/blob/master/CodeBook.md)

* [`run_analysis.R`](https://github.com/maxaldunate/getting-and-cleaning-data-course-project/blob/master/run_analysis.R) the script that make the work (descripton  further). Starting by download the file if is necccessary and finishing with the output file `tidy.txt`

* `tidy.txt` resulset, the output of the proccess. [tidy.txt in this repo](https://github.com/maxaldunate/getting-and-cleaning-data-course-project/blob/master/tidy.txt)

* `data.zip` the file use by the script like a raw or input data. Extracted from the original data set. (See script description further).

## Original Data Source
Representing data collected from the accelerometers from the Samsung Galaxy S smartphone.

[Original dataset used full description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)

[Data Download zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## "R" Scrip description file `run_analysis.R`

### Data Download & UnZip
* You can download from this repo the file `data.zip` (optionally)
* If you download the `data.zip` file, the script will unzip the raw data files.
* If you don't, the script will download and unzip the the neccessary files only
* All this will occurs the first time the script run only.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Related content
[Article Werable Computing](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)
