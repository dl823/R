#Using lattice

library(lattice)

xyplot(nox ~ date, data = MyRData, type = 'l') #NB format is 'y axis ~ x axis'
#can annotate as with basic R plots with ylim = , ylab = , etc

weekdays = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') #define weekdays
test.data = data.frame(nox = 5 * runif(70), no2 = runif(70), weekday = as.factor(rep(weekdays, each = 10))) #make dataframe
test.data$weekday = ordered(test.data$weekday, levels = weekdays) #order days to prevent alphabetical default
xyplot(no2~ nox | weekday, data = test.data, as.table = TRUE) #plot it

#plotting separate years of data on one page:
MyRData$year = as.factor(format(MyRData$date, '%Y')) #put everything in a simple year format
begin.year = min(MyRData$date)
end.year = max(MyRData$date) #define start and end dates
xyplot(nox ~ date | year, data = MyRData, aspect = 0.4, as.table = TRUE, scales = list(relation = 'free', x = list(format = '%b', at = seq(begin.year, end.year, by = '2 month'))), panel = function(x, y) {
  panel.abline(v = seq(begin.year, end.year, by = 'month'), col = 'grey85')
  panel.abline(h = 0, col = 'grey85')
  panel.grid(h = -1, v = 0)
  panel.xyplot(x, y, type = 'l', lwd = 1)
})

wd.cut = cut(MyRData[, 'wd'], breaks = seq(0, 360, length = 9)) #divide up date by wd
wd = seq(0, 360, by = 45) #define levels for plotting
levels(wd.cut) = paste(wd[-length(wd)], '-', wd[-1], 'degrees', sep = '')
summary.data = aggregate(MyRData['nox'], list(date = format(MyRData$date, '%Y-%m'), wd = wd.cut), mean, na.rm = TRUE) #summarise my year/month and wd
newdate = paste(summary.data$date,'-01', sep = '')
newdate = as.Date(newdate, format= '%Y-%m-%d') #format date as y/m/d
summary.data = cbind(summary.data, newdate) #add to a summary
xyplot(nox ~ newdate | wd, #plot nox newdate, new plot for each wd
       data = summary.data, #tae values from summary.data
       layout = c(4, 2), #4 columns, 2 rows
       as.table = TRUE,
       xlab = 'date',
       ylab = 'nox (ppb)',
       panel = function(x, y) {
         panel.grid(h = -1, v = 0)
         panel.abline(v = seq(as.Date('1998/1/1'), as.Date('2007/1/1'), 'years'), col = 'grey85')
         panel.xyplot(x, y, type = 'l', lwd = 1)
         panel.loess(x, y, col = 'red', lwd = 2, span = 0.2)
}) #plot the graphs


