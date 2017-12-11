dat = read.csv('C:/Users/David/Google Drive/PhD/R/Learning/OpenAir_example_data_long.csv', header = TRUE)
dat$date = as.POSIXct(strptime(mydata$date, format = '%d/%m/%Y %H:%M', tz = 'Etc/GMT-1')) #appears as NA in table, but head() shows what you'd expect

mydata = import() #opens a file browser. Select a text/csv file to import, represent with 'mydata'
mydata = import('C:/Users/David/Google Drive/PhD/R/Learning/OpenAir_example_data_long.csv')
#Can innput file path in function instead of using the file browser, more obvious in the code what you've done

mydata = import(na.strings = 'NoData') #represent missing data with 'NoData'
mydata = import(na.strings = '-999') #represent missing data with '-999'
mydata = import(na.strings = '-99.0', '-999') #represent missing data with '-99.0' AND '-999'

import('C:/Users/David/Google Drive/PhD/R/Learning/test.csv', date = mydate, date.format = '%/d.%m.%Y',
       time = 'mytime', time.format = '%H:%M')
#^for importing dates formated dd.mm.YYYY, time HH:MM. NB thing between letters can vary as follows : , . - /
import('C:/Users/David/Google Drive/PhD/R/Learning/test.csv', date = mydate, date.format = '%/m.%d.%Y',
       time = 'mytime', time.format = '%H:%M')
#simply swap m and d if the format is mm/dd/YYYY
#remove %M in time if it's only given as an hour
import('C:/Users/David/Google Drive/PhD/R/Learning/test.csv', date = mydate,
       date.format = '%/m.%d.%Y %H', correct.time = -3600)
#often get a date-time field with 1-24 as the hour. Need to correct, done by seconds (60 x 60 = 3600)

#MAKE SURE DATA DOESN'T HAVE DUPLICATE OR MISSING HOURS FOR DAYLIGHT SAVING OR IT'S A MASSIVE HASSLE
#a list of import options are on P84/p85 of the OpenAir manual

mary = importAURN(site = 'my1', year = 2000:2009) #import all pollutant info from Marylebone 2000-2009 from the AURN database
thedata = importAURN(site = c('my1', 'nott'), year = 2000, pollutant = c('nox', 'no2', 'o3'))
#import nox, no2 and o3 data from Nottingham and Marylebone road in 2000 from the AURN database
#AURN = Automatic Urban and Rural Network

#importKCL() works in a similar way with the King's College London Database. List of options on p87
#importAirbase() function for access to data from the European Environmental Agency
#similarly, airbaseStats() gives precalculated values for means etc



