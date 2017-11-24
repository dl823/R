x = runif(10) #generates 10 random numbers between 0 and 1, saves them to variable 'x'
y = runif(10) #same for new variable 'y'
z = seq(1:10) #generates a sequence of integers from 1 to 10, saves them to variable 'z'
z = seq(1, 10) #identical to above(?)
z = seq(1, 10, length.out = 23) #makes a sequence of 23 evenly spaced numbers from 1 to 10, assigns to 'z'
rep(1, 10) #repeats the number 1 10 times
p = c(1, 3, 5, 10) #concatenates the 4 numbers and assigns to variable 'p'
plot(x,y) #plots x vs y. requires equal number of entries in each dataset.
z = rnorm(1000) #assigns 1000 numbers from a normal distribution to variable 'z'
hist(z) #plots a histogram for the dataset 'z'
help(plot) #opens help info for the plot function (put any function in the bracket)
getwd() #shows the working directory you're currently in
setwd('C:/Users/David/Google drive/PhD/R') #sets the current working directory to the pasth shown