test.data = read.csv('http://www.openair-project.org/CSV/OpenAir_example_data_long.csv', header = TRUE)
#reads the file from the website URL specified

write.csv('exporteddata.csv', row.names = FALSE) #write to csv
save(test.data, file = 'testdata.RData') #saves as a .RData file, usable in R (to current working directory)

load('testdata.RData') #loads the file specified. Must be in the right directory I assume.

x = c(1, 4, 5, 18, 22, 3, 10, -33, -2, 0)
x[4] #returns 18 - the 4th value in the vector. NOTE, 1ST NUMBER IS 1, NOT 0 LIKE IN PYTHON
x[3:6] #returns 3rd to 6th
x[c(-1, -2)] #omits the first and second value. NOTE, NOT LIST FROM THE END LIKE IN PYTHON
which(x>5) #lists the indexes that are of greater value than 5 (in the above, entries 4, 5, 7 and 8)
x[x==18] #specifies values of 18
rev(x) #reverses the order
x[x == 2] = 0 #replaces all instances of the value 2 with 0. Can use other operators (<> etc)

subdata = mydata[1:500, ] #define a subset of the full data, comprising of the first 500 entries
nrow(subdata) #returns 500 (the number of rows in the subset)