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

subdata = MyRData[1:500, ] #define a subset of the full data, comprising of the first 500 entries
nrow(subdata) #returns 500 (the number of rows in the subset)

subdata = subset(MyRData, select = c(nox, no2)) #'define subdata as a subset of MyRData, selecting vectors by concatenating 'nox' and 'no2' entries'
subdata = subset(MyRData, nox > 600, select = c(nox, no2, date)) #defines subdata similarly, but only values greater than 600 for nox, including a date entry

#next bit is date conversion to POSIXct, Will already helped me do this, but I'll note it for completeness

start.date = as.POSIXct('2004-01-01 00:00', tz = 'UTC')
end.date = as.POSIXct('2004-12-31 23:00', tz = 'UTC')
subdata = subset(MyRData, date >= start.date & date <= end.date, select = c(date, nox, no2))
#define start and end dates in POSIXct format, pick timezone. subdata as all datapoints between the two chosen dates

subdata = subset(MyRData, format(date, '%Y') %in% c(1998, 2005)) #make the subset the entries from 1998 and from 2005 only
subdata = subset(MyRData, format(date, '%A') %in% c('Saturday', 'Sunday')) #make the subset only data from weekends

