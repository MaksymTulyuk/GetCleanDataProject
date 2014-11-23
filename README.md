## Get Clean Data: Project

How to run and test the script:

1. Download the file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the file "getdata-projectfiles-UCI HAR Dataset.zip" if your browser hasn't unzipped it yet
3. Download run_analysis.R in the same directory with "UCI HAR Dataset"
4. Run the file: R --no-environ CMD BATCH run_analysis.R
5. The tiny data file will be in: "tidy data set.txt"

The short description how the run_analysis.R works: the file has and runs five main functions: part1, part2, ..., part 5. Each function:
- does one step from the project
- get a data set from the previous step (except the function part1)
- return the data set

After the function part5, the script write the final file "tidy data set.txt"

More information about the functions can be found in the CodeBook.md

