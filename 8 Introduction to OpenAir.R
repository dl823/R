?openair #displays help for the openair once opened

functionName(thedata, options, ...) #generic function form

#Good practise, make each script self contaained - open all libraries, files, define all variables afresh so nothing is needs to be imported from any other scripts

polarPlot(theData) #minimum required for this function - by default sets the pollutant to be nox (if it is available in the dataframe)
#order of options is NOT IMPORTANT:
polarPlot(theData, type = 'year', poll = 'so2') #poll is enough for the options to be uniquely recognised as 'pollutant'

#common options in functions:
#xlab/ylab = 'text'
#main = 'plot title'
#pch = symbol used for points
#cex = size of plot point
#lty = line type
#lwd = linewidth
#layout = c(4,2) for 4 columns, 2 rows
#fontsize = number not easy to change some fontsize but not others...

#type =
#period - splits the data into a before and after graph
#wd - splits into 8 wind directions
#integer- splits the data into quartiles

#use n.levels = number to set intervals, e.g 3 could divide temperature into low, medium and high

#option             splits data by...
#year               year
#hour               hour of the day (0 to 23)
#month              Month of the year
#season             spring, summer, autumn, winter
#weekday            Monday, Tuesday,...
#weekend            Saturday, Sunday, weekday
#monthyear          every month-year combination
#gmtbst             separately considers daylight saving time periods
#daylight           night time and daylight

#in order to import, data must be 'rectangular', data in columns with the top entries being headers.
#fields with numeric data should have no characters except for missing data (this must be consistent and specified)
#date/time field must be titled 'date'
#windspeed and direction must be 'ws' and 'wd' respectively. assumes units m s^-1
#variable names can be upper or lower, but MUST NOT START WITH A NUMBER
#a variable called pm25 will be plotted as PM2.5

#colours

polarPlot(mydata) #default colours
polarPlot(mydata, cols = 'jet') #use jet colour scheme
polarPlot(mydata, cols = c('yellow', 'green')) #scale from yellow to green
polarPlot(mydata, cols = c('navajowhite2', 'violet', 'seagreen')) #scale from navajowhite2 to seagreen through violet...
#beautiful...

library(openair)
printCols = function(col, y) {
  rect((0:200) / 200, y, (1:201) / 200, y + 0.1, col = openColours(col, n = 201), border = NA)
  text(0.5, y + 0.15, deparse(substitute(col)))
} #defines a small function for plotting

plot(1, xlim = c(0, 1), ylim = c(0, 1.6), type = "n", xlab = "", ylab = "", axes = FALSE)
printCols("default", 0)
printCols("increment", 0.2)
printCols("heat", 0.4)
printCols("jet", 0.6)
printCols("hue", 0.8)
printCols("brewer1", 1.0)
printCols("greyscale", 1.2)
printCols(c('tomato', 'white', 'forestgreen'), 1.4)
#plots scales of the above colour schemes

#auto text formatting: ylab = 'nox (ug/m3)' will give you micrograms per meter cubed, and subscript the 'x' in 'nox'
#can be unhelpful - if so, most functions have an 'auto.text' option, set to TRUE by default. Can manually do labels by setting it to FALSE

a = windRose(mydata)
b = polarPlot(mydata)
print(a, split = c(1, 1, 2, 1)) # numbers are 'position this in 1st column 1st row, total of 2 columns 1 row'
print(b, split = c(2, 1, 2, 1), newpage = FALSE)
#plot two graphs and display together, one on the left, one on the right

print(a, position = c(0, 0, 0.5, 0.5), more = TRUE)
print(b, position = c(0.5, 0.5, 1, 1))
#position option defines the rectangle that the plot occupies with co-ordinates: c(xmin, ymin, xmax, ymax)

library(RColorBrewer)
library(latticeExtra)
timePlot(selectByDate(mydata, year = 2003, month = 'aug'), pollutant = c('nox', 'o3', 'pm25', 'pm10', 'ws'), y.relation = 'free')
trellis.last.object() + layer(ltext(x = as.POSIXct('2003-08-04'), y = 200, labels = 'some missing data'), rows = 1)
#trellis.last.object() just refers to the last plot plotted. layer function used to add text. ltext (lattice text)
#used for the text. x = and y = define the location on the plot where the text will go. 'pos' option in 'ltext' can be
#used to put the text below the specified co-ordinates. **MY AXES SEEMS POORLY SCALED? >>>
# add margument y.relation = 'free' allows the scales to be different between graphs

trellis.last.object() + 
  layer(lpolygon(x = c(as.POSIXct('2003-08-07'), as.POSIXct('2003-08-07'),
                       as.POSIXct('2003-08-12'), as.POSIXct('2003-08-12')),
                 y = c(-20, 600, 600, -20), col = 'grey', border = NA), under = TRUE, rows = 2)
#grey shaded area. I think if you put the x an y both a posix in this case, it assumes between the two x points, infinite on y.

trellis.last.object() + layer(ltext(x = as.POSIXct('2003-08-09 12:00'), y = 50,
                                    labels = '!!episode!!', col = 'yellow', font = 2, cex = 1.5), rows = 2)
#!!episode!! text

trellis.last.object() + #originally written as plt = plt + didn't work, no idea what plt was meant to be.
  layer(lpolygon(x = c(as.POSIXct('2003-08-21'), as.POSIXct('2003-08-21'),
                       as.POSIXct('2003-08-23'), as.POSIXct('2003-08-23')),
                 y = c(4, 8, 8, 4), col = 'blue', border = NA, alpha = 0.2), rows = 5)
#blue shading on row 5. 'rows' denotes which graph

trellis.last.object() +
  layer(larrows(as.POSIXct('2003-08-01'), 100,
                as.POSIXct('2003-08-08 14:00'),
                100, code = 3, angle = 30), rows = 1)
#arrow on row 1. oddly 'angle' defines the 'sharpness' of the arrowhead...

trellis.last.object() +
  layer(panel.abline(v = as.POSIXct('2003-08-25'), lty = 5), rows = 4)
#adds ref. line
trellis.last.object() +
  layer(ltext(x = as.POSIXct('2003-08-25 08:00'), y = 60, labels = 'reference line', srt = 90), rows = 4)
#labels ref. line as such

trellis.last.object() +
  layer(lpoints(x[200], y[200], pch = 16, cex = 1.5), rows = 4)
#labels the 200th point (without knowing the actual date or value)

trellis.last.object() +
  layer({maxy = which.max(y);
    ltext(x[maxy], y[maxy], paste(y[maxy], 'ppb'),
          pos = 4)}, rows = 2)
#labels y value of the max point in row 2

poly.na = function(x1, y1, x2, y2, col = 'black', alpha = 0.2) {
  for (i in seq(2, length(x1)))
    if (!any(is.na(y2[c(i - 1)])))
      lpolygon(c(x1[i-1], x1[i], x2[i], x2[i-1]),
               c(y1[i-1], y1[i], y2[i], y2[i-1]),
               col = col, border = NA, alpha = alpha)
} #write a function for colouring the ploygon defined as the area between the baseline and the plotted data,
#excluding gaps in the dataset

trellis.last.object() +
  layer({id = which(x >= as.POSIXct('2003-08-11') &
                    x <= as.POSIXct('2003-08-25'));
  poly.na(x[id], y[id], x[id], rep(0, length(id)),
          col = 'darkorange')}, rows = 1)
#coloured area under the line in 1st row, nothing where there are no data

trellis.last.object() +
  layer(poly.na(x, y, x, rep(0, length(x)),
                col = 'green', alpha = 1), rows = 3)

trellis.last.object() +
  layer(poly.na(x, ifelse(y < 20, NA, y), x, rep(20, length(x)),
                col = 'yellow', alpha = 1), rows = 3)

trellis.last.object() +
  layer(poly.na(x, ifelse(y < 30, NA, y), x, rep(30, length(x)),
                col = 'orange', alpha = 1), rows = 3)

trellis.last.object() +
  layer(poly.na(x, ifelse(y < 40, NA, y), x, rep(40, length(x)),
                col = 'red', alpha = 1), rows = 3)

arc = function(theta1 = 30, theta2 = 60, theta3 = theta1, theta4 = theta2, lower = 1, upper = 10){
  if (theta2 < theta1) {
    ang1 = seq(theta1, 360, length = abs(theta2 - theta1))
    ang2 = seq(0, theta2, length = abs(theta2 - theta1))
    angles.low = c(ang1, ang2)
    ang1 = seq(theta1, 360, length = abs(theta4 - theta3))
    ang2 = seq(0, theta2, length = abs(theta4 - theta3))
    angles.high = c(ang1, ang2)
  }else{
    angles.low = seq(theta1, theta2, length = abs(theta2 - theta1))
    angles.high = seq(theta3, theta4, length = abs(theta4 - theta3))
  }
  x1 = lower * sin(pi * angles.low / 180)
  y1 = lower * cos(pi * angles.low / 180)
  x2 = rev(upper * sin(pi * angles.high / 180))
  y2 = rev(upper * cos(pi * angles.high / 180))
  data.frame(x = c(x1, x2), y = c(y1, y2))
}
#define function 'arc' for co-ordinates in a polar plot

polarPlot(mydata, pollutant = 'so2', col = 'jet')
trellis.last.object() + layer(ltext(-12, -12, 'A', cex = 2)) #add 'A' at point (-12, -12)
trellis.last.object() + layer(ltext(10, 2, 'B', cex = 2, col = 'white')) #add a white 'B' at point (10, 2)
trellis.last.object() + layer(lsegments(0, 0, -11.5, -11.5, lty = 5)) #add an arc to show 'area of interest'
trellis.last.object() + layer(lpolygon(x = arc(theta1 = 60, theta2 = 120, lower = 2, upper = 15)$x,
                                      y = arc(theta1 = 60, theta2 = 120, lower = 2, upper = 15)$y,
                                      lty = 1, lwd = 2)) #add a sector over an area of interest

timeVariation(mydata)
library(grid)
grid.locator(unit = 'npc') #allows you to click on plot to get a co-ordinate (0,0) btottom left, (1,1) top right

timeVariation(mydata)
grid.text(x = 0.755, y = 0.525, label = 'yoohooo!', gp = gpar(cex = 2, font = 2, col = 'blue'))
grid.lines(x = c(0.735, 0.760), y = c(0.560, 0.778), arrow = arrow()) #add an arrow
grid.text(x = 0.736, y = 0.560, label = 'maximum', just = 'left') #add next next to the arrow
