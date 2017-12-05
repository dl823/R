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

timePlot(MyRData, pollutant = c('site1.nox', 'site2.nox', 'site3.nox', 'site4.nox', 'site5.nox', 'site6.nox', 'site7.nox', 'site8.nox', 'site9.nox', 'site10.nox'))
#column format, really longwinded
timePlot(MyRData, pollutant = 'nox', type = 'site')
#plot 3 columns: date, nox and site number. This way you have 3 columns regardless of no. sites

thedata = head(MyRData, 3)
library(reshape2)
library(plyr)

thedata = melt(thedata, id.vars = 'date')
#change from having a column for every variable to 2 clolumns, one defining the variable, the other giving the value

thedata = dcast(thedata, ...~variable) #puts it back to separate columns (new column for stuff after ~)

site1 = thedata
site1$site = 'site1' #adds a column titled 'site' and enters 'site one' in all rows
site2 = thedata
site2$site = 'site2' #same data as another variable, site 2

alldata = rbind.fill(site1, site2) #combines site1 and site 2 data

alldata = melt(alldata, id.vars = c('site', 'date')) #(time) date and site are the 'id variables'
alldata = dcast(alldata, ... ~ site + variable) #want unique combinations of site and date

nox = read.csv('~/openair/Data/hour-day.csv', header = FALSE) #I can't find tthis file anywhere?
nox = as.data.frame(t(nox)) #t = transpose function, hours now in columns. Convert back to dataframe
nox = stack(nox) #stacks the columns (hours) on top of each other
nox = nox$values #get values out from the stacking process

nox = stack(as.data.frame(T(NOX)))[, 'values'] #the 3 lines above, compresed into one line

nox = read.csv('~/openair/Data/hour-day.csv', header = FALSE)
nox = t(nox)
nox = as.vector(nox) #data transposed and converted to a vector. this process works by columns, not rows
#just another way of doing the above

test.data = data.frame(grp1 = 1:3, grp2 = 10:12, grp3 = 20:22)
stacked = stack(test.data)
mytest.data = data.frame(grp1 = 1:3, grp2 = 10:12, grp3 = 20:22, grp4 = 53:55) #just my own fiddling
mystacked = stack(mytest.data)

#daily means from hourly data - SOUNDS USEFUL. 'easy for windspeed, harder for wind direction'

dailymean = function(mydata) {
    mydata$u = sin(2 * pi * mydata$wd / 360) #one directional wd component
    mydata$v = cos(2 * pi * mydata$wd / 360) #perpendicular wd component
    dailymet = aggregate(mydata, list(Date = as.Date(mydata$date)), mean, na.rm = TRUE) #mean wd
    dailymet = within(dailymet, wd = atan2(u, v) * 360 / 2 / pi)
    ids = which(dailymet$wd < 0)
    dailymet$wd[ids] = dailymet$wd[ids] + 360
    dailymet = subset(dailymet, select = c(-u, -v, -date))
    dailymet
}
#above defines a function for use

mydaily = dailymean(mydata) #calclate daily means
head(mydaily) #seems to be something wrong with the function? can't spot it for the life of me...
#give up, move on...

par(mfrow = c(1, 2)) #sets up the plot window for 1 row and 2 columns
#apparently openair functions 'lattice' graphics and need to be handled differently... great

means = tapply(mydata$nox, format(mydata$date, '%Y-%m'), mean, na.rm = TRUE)
dates = seq(mydata$date[1], mydata$date[nrow(mydata)], length = nrow(means))
plot(dates, means, type = 'l', col = 'skyblue2', xlab = 'year', ylab = 'nox (ppb)', main = 'blah') #1st plot

means = tapply(mydata$no2, format(mydata$date, '%Y-%m'), mean, na.rm = TRUE)
dates = seq(mydata$date[1], mydata$date[nrow(mydata)], length = nrow(means))
plot(dates, means, type = 'l', col = 'darkgreen', xlab = 'year', ylab = 'no2 (ppb)', main = 'blah') #2nd plot

png('myPlot.png')
polarPlot(mydata, pollutant = 'so2')
dev.off() #must have this else the device won't close and the file won't be written

png('myPlot.png', width = 5 * 300, height = 4.5 * 300, res = 300)
polarPlot(mydata, pollutant = 'so2')
dev.off() #'dpi' measure of resolution. change the res = to chagne resolution

png('myPlot.png', width = 3.5 * 300, height = 3 * 300, res = 300)
polarPlot(mydata, pollutant = 'so2')
dev.off() #font is kinda set, but making the plot smaller makes the text bigger by comparison

bg = transparent #argument in the polarPlot function, for overlaying data on a map

x = mydata$nox
y = mydata$no2
x.max = max(x, na.rm = TRUE)
y.max = max(y, na.rm = TRUE) #find max values
x.int = 5
y.int = 2 #set the bin interval
x.bin = cut(x, seq(0, x.max, x.int))
y.bin = cut(y, seq(0, y.max, y.int)) #bin the data
freq = table(x.bin, y.bin) #make a frequency table
x.range = seq(0 + x.int/2, x.max - x.int/2, x.int)
y.range = seq(0 + y.int/2, y.max - y.int/2, y.int) #define x and y intervals for plotting
image(x = x.range, y = y.range, freq, col = rev(heat.colors(20))) #plot the data

library(lattice)
grid = expand.grid(x = x.range, y = y.range)
z = as.vector(freq)
grid = cbind(grid, z)
levelplot(z ~x * y, grid, col.regions = rev(heat.colors(20)))
#quicker way of doing the above with the lattice package

#use 'expression' to input symbols e.g:
plot(1, 1, xlab = expression('Temperature (' * degree * 'C)'), ylab = expression('PM'[10]~'(' * mu * 'g m' ^-3 * ')'), main = expression('PM'[2.5] * ' and NO'[x] * ' at Marylebone Road'), type = 'n')
text(1, 1, expression(bar(x) == sum(frac(x[i], n), i==1, n)))
text(.8, .8, expression(paste(frac(1, sigma*sqrt(2*pi)), ' ', plain(e)^{frac(-(x-mu)^2, 2*sigma^2)})), cex = 1.2)
text(1.2, 1.2, expression((hat(beta) == X^t * X)^{-1} * X^t * y))
#just a load of example plots

#store larger amounts of data not in a csv, but in a database:

library(RODBC) #can't find?
Sys.setenv(TZ = 'GMT')
chanel = odbcConnectAccess2007('C:/users/David/Google Drive/PhD/R/Learning/OpenAir_example_data_long.mdb')
#this would connect to the Access database file if I had it...

test.data = sqlQuery(chanel, 'select * from dbdata') #read in all data
test.data = sqlQuery(chanel, 'select date, nox, no2 from database') #read in only date, nox and no2

test.data = sqlQuery(chanel, 'select * from dbdata where nox > 500') #only data where nox > 500

test.data = sqlQuery(chanel, 'select * from dbdata where date >= #1/1/1998# and date <= #31/12/1999 23:00:00#')
# select between 2 dates

close(chanel) #closes the connection, shockingly
