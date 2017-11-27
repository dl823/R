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

test.dat = data.frame(lond.nox = 1, lond.no2 = 3, nox.back = 4, no2.back = 1)
test.dat

grep(pattern = 'nox', names(test.dat)) #returns [1]  1  3 (the values in the column with 'nox' in the name)

sub.dat = test.dat[ , grep(patter = 'nox', names(test.dat))] #the above, done in one line,saves as a variable
sub.dat

timePlot(MyRData, pollutant = names(MyRData)[grep(pattern = 'pm', names(MyRData))])
#timePlot function from OpenAir, one for each string in MyRData with 'pm' in the title

path.files = 'D:\\temp\\' #define variable as the directory with multiple files you wish to be read
test.data = lapply(list.files(path = path.files, pattern = '.csv'),function(.file)read.csv(paste(path.files,  ''), header = TRUE))
test.data= do.call(rbindtest.data) #in theory this would open all the csvs in the direcory. Since we don't have this data, we can't

airpol = data.frame(date = seq(as.POSIXct('2007-01-01'), by = 'hours', length = 24), nox = 1:24, so2 = 1:24)
met = data.frame(date = seq(as.POSIXct('2007-01-01'), by = 'hours', length = 24), ws = rep(1,24), wd = rep(270, 24))
#make up 2 files, one for air pollution, one for meteorological. Same days and time inetrvals, different measurements

test.data = merge(airpol, met) # merges the two files into one, (i.e, 2 chemicals and 2 meteorological values against one date column)
#only merges where there are data in both files. e.g. if one file had 2 hour and the other 12, you'd only get 2 hours merged
test.data = merge(airpol, met, all = TRUE) #would merge ALL values, even if one was missing. In this case, listed as NA.

site1 = airpol
site2 = airpol

both = merge(site1, site2, by = 'date', suffixes = c('.st1', '.st2'), all = TRUE)
#two sites both with the same column titles, want to merge so nox and so2 of both sites displayed together

year1 = data.frame(date = seq(as.POSIXct('2007-01-01'), by = 'hours', length = 24), nox = 1:24, so2 = 1:24)
year2 = data.frame(date = seq(as.POSIXct('2008-01-01'), by = 'hours', length = 24), nox = 1:24, so2 = 1:24, pm10 = 1:24)
test.data = merge(year1, year2, all = TRUE)
#merges 2 years of data where 2nd year has new measurement. Fills in where values are absent with 'NA'

head(test.data) #see 3rd column filled with NA
tail(test.data) #see 3 columns with values

airpol = airpol[-c(2,3 ), ] #select all but record 2 and 3
#NB repeating these three lines causes lined 4 and 5 to be removed, then 6 adn 7, etc
all.dates = data.frame(date = seq(as.POSIXct('2007-01-01'), by = 'hours', length = 24))
test.data = merge(all.dates, airpol, all = TRUE)

library(zoo) #can't find package called zoo... makes the next bit of the tutorial rather hard...
#something about filling in missing values instead of replacing with NA, presumably so maths can be done...
#can interpolate i.e. guess likely values and input them. seems legit...

















