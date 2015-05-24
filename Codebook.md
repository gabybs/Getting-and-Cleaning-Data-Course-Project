# Code book

This document provides information about the script "run_analysis.R", provided in this repository.

## Original Data Set

Taken from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

## Data set `tidydata.txt`

The "tidydata.txt" is the result of cleaning an selecting data from the measurements that were collected on the experiment that was previously explained. The orignal data set that was used in this project can be found in: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .

Here is a description of the variables found in `tidydata.txt`:

* `subject`:is the subject number that performed an activity, there are 30 subjects in total
* `activity`; is the activity performed by the subject. The are six activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.

A total of 79 features were selected from the original data: only the estimated mean and standard deviations. These features form the 79 other variables in the dataset, making a total of 81 columns. The feature names from the original data have been rewritten, like this:

* prefix t is replaced by time
* prefix f is replaced by frequency
* Acc is replaced by Accelerator
* Gyro is replaced by Gyroscope
* Mag is replaced by Magnitude
* BodyBody is replaced by Body

For example:

* `fBodyAcc-mean()-Z` becomes `freqBodyAccMeanZ`

A full description of the features can be found in the file `features_info.txt` included in the original data set.

The "-XYZ" is used to denote 3 axial signals in the X, Y, Z directions. For example:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ

The set of variables that were used in the orignal data are:


* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values.
* iqr(): Interquartile range
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal
* kurtosis(): kurtosis of the frequency domain signal
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

For more information on how was worked the `tidydata.txt` look for the READ.md provided in this repository.