# here i can write anything i want, the software won't read it (by putting #in front)

                                                                           # R AS A CALCULATOR
2+3
# ASSIGN TO AN OBJECT
result1 <- 2+3
result1
result2 <- 5+3
result2
final <- result1 * result2
final


                                                                        # ARRAYS (bunch of inforation all toghether)
sophi_thesis <- c(10, 20,30,50,70) #microplastics
                                                     #functions have parenthesis and inside them there are arguments

paula <- c(100,500,600,1000,2000) #people
plot (paula, sophi_thesis)

                                                                                #to add arguments in a plot you use ",":
plot(paula, sophi_thesis , xlab = "number of people", ylab0"microplastics")
                                                                                          #or
people <- paula
microplastics <- sophi_thesis

                 #pch = points of charachter: figures to represent points in graphs (each of them associated to a number)
plot(people, microplastics)
                    #to add the filled circles we add pch = there is an explanation online and you can pick any number
plot(people, microplastics, pch=19) 
plot(people, microplastics, pch=19, cex=2)                                   #cex is size of the data points
plot(people, microplastics, pch=19, cex=2, col="yellow")                     #colour change is col="colour"

 # simple operation
10 + 10

# this is an object
duccio <- 10 + 10
duccio

# objects
adam <- 5 + 3
duccio + adam

# arrays
diameter <- c(100, 10, 50, 20, 15)
iron <- c(10, 1000, 20, 700, 900)

# a function
plot(iron, diameter) # iron and diameter are arguments!
plot(iron, diameter, pch=19) # https://www.google.com/search?client=ubuntu-sn&hs=Ssn&sca_esv=564367827&channel=fs&sxsrf=AB5stBhOTkEGpHkLRMvuoUQuTCdqYjKtEw:1694448980289&q=pch+in+R&tbm=isch&source=lnms&sa=X&ved=2ahUKEwjzmr2s-qKBAxUOGuwKHUdlAnMQ0pQJegQIDBAB&biw=960&bih=484&dpr=2#imgrc=lUw3nrgRKV8ynM
plot(iron, diameter, pch=19, cex=2)
plot(iron, diameter, pch=19, cex=2, col="red")

# do you want info about functions?
?plot()
    
