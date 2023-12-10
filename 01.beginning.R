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

     
