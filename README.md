# Getting and cleaning data Project
## 1.How to use the code
Download the Samsung data and unziped, make sure the code run_analysis.R is in the same folder with the unziped Samsung data. Then run the script, you may get the final tidy data in a variable named results.
## 2.How the script works
###2.1 read the train data
Read the X_train data and get names from features.txt, remove - and () in names with dot. Read the train_y data and replace the numbers with descriptive activity names. Then read the subject data from subject_train.txt, which is the 30 person id I think.

###2.2 read the test data
the data format is the same as train data, so the process is the same.

###2.3 Merge the data
Merge the train data, test data firstly, then merge the train and test data by rbind.

###2.4 Extracts only the measurements on the mean and standard deviationuu 
Select the columns contains std or mean or activity(the activity names, walking and laying .etc) or subject(testing person id)

###2.5 calcuate the average for every measurement
It's pretty simple about this step, we group by the result by subject and activity, then calculate the mean value by summarise_each.
