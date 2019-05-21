## R Markdown

* The cleaned data is contained in the tibble data_cleaned.
* The averaged data (per subject/activity) is contained in the tibble data_avg.

In order to execute the script the data directory variable dir_data has to be set correctly.

The run_analysis.R executes the following transformations:

1) For both, the test and the train data, combine the data using the subjects, X, y text-files.
2) Use the labels from features.txt to label the variables in X
3) Combine test and training data into one tibble
4) Remove all variables which do not contain the "std" or "mean" in their name
5) Read the activity names from activity_labels.txt
6) Replace the activity-id by their label
7) Use a copy of the cleaned data to form the averages per variable for each possible pair of subject/activity

  