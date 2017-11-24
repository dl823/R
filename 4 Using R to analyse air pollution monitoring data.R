MyRData <- read.csv("OpenAir_example_data_long.csv", header = TRUE) # Adds the file specified (must be csv) in current working directory as MyRData to R
summary(MyRData) #displays the data present in 'MyRData'
names(MyRData) #just lists the cariables that have been read in
summary(MyRData$nox) #summary of one variable (here, nox) in the dataframe
mean(MyRData$nox) #mean of the 'nox' variable in MyRData. Returns 'NA' here due to missing datapoints (inputted as NA by R)
mean(MyRData$nox, na.rm = TRUE) #Mean as above, but excluding values of 'NA'. Presumably can do this for real values to, e.g. 0.

hist (MyRData$no2, main = "Histogram of nitrogen dioxide", xlab = "Nitrogen dioxide (ppb)")
#plots a histogram of no2, titles it and laels the x axis (I assume y is freq. by default)

newdata = na.omit(MyRData) #makes a new dataset comprised of the old one minus the 'NA's
hist (MyRData$no2, main = "Histogram of nitrogen dioxide", xlab = "Nitrogen dioxide (ppb)", col = 'lightblue')
#as above, but coloured blue!)

dens = density(MyRData$no2, na.rm = TRUE) #assign density of no2 to 'dens'
plot(dens, main = 'Density plot nitrogen dioxide', xlab = 'nitrogen dioxide (ppb)')
#plot density of no2 data. Like  a histogram, but no bandwidth.

plot(MyRData$date, MyRData$nox, type = 'l', xlab = 'year', ylab = 'Nitrogen oxides (ppm)')
#*should* plot NOx over time against date. get error 'cannot allocate vector size of 32.0 GB'
#problem was that date was stored as a factor - made it too inefficient for my PC to read.
#Will showed me 'lubridate' package. adds function
test$date = dmy_hm(test$date) #turns factor into a POSIXct, format year, month, day, hour, minute.
#check format of data, pick correct function for lubridate to convert it correctly.

plot(MyRData$date[1:500], MyRData$nox[1:500], type = "l", xlab = "date", ylab = "Nitrogen oxides (ppb)")
#plots only values 1-500 in the dataset above

means = aggregate(MyRData['nox'], format(MyRData['date'], '%Y-%m'), mean, na.rm = TRUE)
#calclates monthly means

means$date = seq(min(MyRData$date), max(MyRData$date), length = nrow(means))
#'derive proper sequence of dates'
#as I understand it, it says make an evenly spaced sequence of numbers between the 'lowest' date and the
#'highest' date with a total number of points equal to the number of means we have to plot against it.

plot(means$date, means[, 'nox'], type = 'l')
#plots monthly averaged nox

means = aggregate(MyRData[-1], format(MyRData[1], '%Y-%m'), mean, na.rm = TRUE)
#aggregate all columns except the first ([-1]), format my the first column, in form year-month

head(means) #displays top 6(?) values of each column

means$date = paste(means$date, '-15', sep = '')
means$date = as.Date(means$date)
#y-m not recognised as a date. append 15 as the day for each month (i.e put the mean datapoint in the
#middle of the month

dates = with(MyRData, seq(date[1], date[nrow(MyRData)], length = nrow(means)))
plot(dates, means[, 'nox'], type = 'b', lwd = 1.5, pch = 16, col = 'darkorange2', xlab = 'year', ylab = 'nitrogen oxides (ppb)', ylim = c(0, 310), main = 'Monthly mean nitrogen oxides at Marylebone Road')
grid() #adds gridlines
#plots monthly mean of nox at Marylebone road. lwd = linewidth. pch = solid filled circle (datapoint appearance)
#ylim sets the lower and upper limits of the y axis. Can presumeably do the same for xlim

#Apparently OpenAir has much easier ways of doing this kind of thing with 'timeAverage' functions...

means = aggregate(MyRData['nox'], format(MyRData['date'], '%w-%H'), mean, na.rm = TRUE)
#calculate hourly means across the week(?)
plot(means$nox, xaxt = 'n', type = 'n', xlab = 'Day of Week', ylab = 'Nitrogen Oxides (ppb)', main = 'Nitrogen Oxides at Marylebone Road by Day of the Week')
#just makes axes, labels, title
axis(1, at = seq(1, 169, 24), labels = FALSE)
#makes tick marks on x-axis
days = c('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat')
loc.days = seq(13, 157, 24)
#name the days, assign them certain 'hours' for the lables to be positioned at
#remember, sequence = from 1st to 2nd, spaced by 3rd
mtext(days, side = 1, line = 1, at = loc.days)
#adds the lables you defined at the positions you defined
abline(v = seq(1, 169, 24), col = 'grey85')
#adds grey coloured vertical (v) gridlines 24 hours apart from hour 1 to 169
lines(means$nox, col = 'yellow4', lwd = 2)
#adds a line for the mean nox values in a disgusting yellow colour :')

means = aggregate(MyRData['nox'], format(MyRData['date'], '%w-%H', mean, na.rm = TRUE)
plot(means$nox, xaxt = 'n', type = 'n', ylim = c(60, 270), xlab = 'day of week', ylab = 'NOx (ppb)', main = 'NOx at Marylebone Road by day of week')
axis(1, at = seq(1, 169, 24), labels = FALSE)
days = c('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat')
loc.days = seq(13, 157, 24)
mtext(days, side = 1, line = 1, at = loc.days)
ylow = 60; yhigh = 270
xleft = seq(1, 145, 48)
xright = xleft + 24 #defining areas for coloured rectangles for each day
rect (xleft, ylow, xright, yhigh, col = 'lightcyan', border = 'lightcyan')
lines(means$nox, col = 'darkorange2', lwd = 2)
#kinda a long way to do it, no? especially if you have many variables to plot against each other...
#R had a pairs function, plots everything against everything else basically...
                  
plot(as.factor(format(mydata$date, "%m")), mydata$o3)
#monthly box and whisker plot
                  
plot(as.factor(format(mydata$date, "%Y-%m")), mydata$no2, col = "lightpink")
#yearly-monthly box and whisker plot
                  
pairs(mydata[sample(1:nrow(mydata), 500), c(1, 2, 3, 4, 5)], lower.panel= panel.smooth, upper.panel = NULL, col = "skyblue3")
#plots all 5 variables specified against one another!