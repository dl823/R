add.two = function(a = 1, b = 2)
{a + b} #write a function that accepts two arguments, a and b. The body of the function is put in {}

add.two(10, 5) #returns 15 as an output

add.two(c(1, 2, 3), 2) #add 2 to each of the numbers 1, 2 and 3. returns '3 4 5'

add.two(c (1, 2, 3),  c(5, 6, 7)) #adds 5 to 1, 6 to 2 and 7 to 3. returns '6 8 10'

add.two() #returns '3'. This is because we defined a = 1 and b = 2 as default values when we made the function