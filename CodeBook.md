## How run_analysis.R transform data

### Short introduction

The file run_analysis.R has and runs five main functions: part1, part2, ..., part 5. Each function:

- does one step from the project
- get a data set from the previous step (except the function part1)
- return the data set

After the function part5, the script write the final file "tidy data set.txt"

### The function part1:

- get two sets "train" and "test" via the function "joinDataInSet", merge them and return
- the function "joinDataInSet" read files with subjects, labels, experiments and join them accordinly
- subjects and labels are read as "factor" and experiments as "double"

### The function part2:

- receive the data set from the part 1
- get column numbers with the strings "mean" (Mean) and "std" (Standard Deviation)
- subset the data set with column numbers and return it

### The function part3:

- receive the data set from the part 2
- replace numbers with the labels/strings based on activity_labels.txt
- return the data sets with the strings in labels

### The function part4:

- receive the data set from the part 3
- add the descriptive names to the columns based on "features.txt"
- the names from "features.txt" are transformed into more readable format by the rules described in the bottom of the text
- return the data sets with the names on each column

### The function part5:

- receive the data set from the part 3
- subset data set based on subjects AND labels
- get average on subsetted data
- return the subsetted data

### Transformation rules for the part 4:

- remove all dashes
- replace "mean()" with "Mean", "std()" -> "StandardDeviation", "Acc" -> "Accelerometer", "Gyro" -> "Gyroscope", "Mag" -> "Magnitute"
- replace in the beginning of each line "t" with "Time" and "f" with "Frequency"

