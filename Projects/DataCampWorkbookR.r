4+8
mylogical<-TRUE
class(mylogical)
vegas <- "Go!"
numeric_vector <- c(1, 10, 49)
character_vector <- c("a", "b", "c")

# Complete the code for boolean_vector
boolean_vector <-c(TRUE,FALSE,TRUE)
# Poker winnings from Monday to Friday
poker_vector <- c(140, -50, 20, -120, 240)

# Roulette winnings from Monday to Friday
roulette_vector <- c(-24,-50,100,-350,10) 
names(roulette_vector) <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

A_vector <- c(1, 2, 3)
B_vector <- c(4, 5, 6)

# Take the sum of A_vector and B_vector
total_vector <- A_vector + B_vector

# Print out total_vector
total_vector

total_daily <- poker_vector + roulette_vector
total_daily
# Total winnings with poker
total_poker <- sum(poker_vector)

# Total winnings with roulette
total_roulette <- sum(roulette_vector)

# Total winnings overall
total_week <- total_roulette + total_poker

total_week


total_poker <- sum(poker_vector)
total_roulette <-sum(roulette_vector)

# Check if you realized higher total gains in poker than in roulette
total_poker > total_roulette
poker_wednesday <- poker_vector[3]
poker_midweek <- poker_vector [c(2,3,4)]
roulette_selection_vector <- roulette_vector[c(2:5)]
poker_start <- poker_vector[c("Monday","Tuesday","Wednesday")]
mean(poker_start)


names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector

# Which days did you make money on poker?
selection_vector <- poker_vector>0

# Print out selection_vector
selection_vector

poker_winning_days <- poker_vector[selection_vector]
poker_winning_days

roulette_winning_days <- roulette_vector[selection_vector]
roulette_winning_days


# Box office Star Wars (in millions!)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Create box_office
box_office <- c(new_hope, empire_strikes, return_jedi)

# Construct star_wars_matrix
star_wars_matrix <- matrix(box_office, nrow = 3, byrow = TRUE) 


# Box office Star Wars (in millions!)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Construct matrix
star_wars_matrix <- matrix(c(new_hope, empire_strikes, return_jedi), nrow = 3, byrow = TRUE)

# Vectors region and titles, used for naming
region <- c("US", "non-US")
titles <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi")

# Name the columns with region
colnames(star_wars_matrix) <- region

# Name the rows with titles
rownames(star_wars_matrix)<-titles

# Print out star_wars_matrix
star_wars_matrix

# Calculate worldwide box office figures
worldwide_vector <- rowSums(star_wars_matrix)
worldwide_vector
# Bind the new variable worldwide_vector as a column to star_wars_matrix
all_wars_matrix <- cbind(star_wars_matrix,worldwide_vector)

phantom<- c(474.5, 552.5)
clone <- c(310.7, 338.7)
revenge<-c(380.3, 468.5)

star_wars_matrix2<- matrix(c(phantom,clone,revenge),nrow = 3,byrow = TRUE)
star_wars_matrix2
names2<- c("US","Non-US")
colnames(star_wars_matrix2) <-names2
star_wars_matrix2
rownames(star_wars_matrix2)<- c("Phantom Menace","Clone Wars","Revenge of Sith")
star_wars_matrix2

all_wars_matrix <- rbind(star_wars_matrix,star_wars_matrix2)
all_wars_matrix

total_revenue_vector <- colsums(all_wars_matrix)

totals<-rowSums(all_wars_matrix)

all_wars_matrix_totals<- cbind(all_wars_matrix,totals)
all_wars_matrix_totals

colSums(all_wars_matrix_totals)


# all_wars_matrix is available in your workspace
all_wars_matrix

# Select the non-US revenue for all movies
non_us_all <- all_wars_matrix[,2]
non_us_all  
# Average non-US revenue
non_us_all_mean<-mean(all_wars_matrix[,2])
non_us_all_mean 
# Select the non-US revenue for first two movies
non_us_some <- all_wars_matrix[1:2,2] 
non_us_some  
# Average non-US revenue for first two movies
mean(non_us_some)

visitors <- all_wars_matrix/5
colnames(visitors)<- c("US visitors","non-US Visitors")  
# Print the estimate to the console
visitors
View(visitors)
head(visitors,1) ## default is 6



# all_wars_matrix and ticket_prices_matrix are available in your workspace
all_wars_matrix
ticket_prices_matrix

# Estimated number of visitors
visitors <- all_wars_matrix/ticket_prices_matrix 
colnames(visitors)<- c("US Visitors","non-US visitors")
visitors
# US visitors
us_visitors <- visitors[,1]
us_visitors
# Average number of US visitors
mean(us_visitors)


# Sex vector
sex_vector <- c("Male", "Female", "Female", "Male", "Male")

# Convert sex_vector to a factor
factor_sex_vector <- factor(sex_vector)
# Print out factor_sex_vector
factor_sex_vector


survey_vector <- c("M", "F", "F", "M", "M")
factor_survey_vector <- factor(survey_vector)

# Specify the levels of factor_survey_vector
levels(factor_survey_vector) <- c("Female", "Male")

factor_survey_vector

speed_vector <- c("medium", "slow", "slow", "medium", "fast")

# Create speed_vector
speed_vector <- c("medium", "slow", "slow", "medium", "fast")

# Convert speed_vector to ordered factor vector
factor_speed_vector <- factor (speed_vector, ordered=TRUE, levels = c("slow","medium","fast"))

# Print factor_speed_vector
factor_speed_vector
summary(factor_speed_vector)

# Create factor_speed_vector
speed_vector <- c("medium", "slow", "slow", "medium", "fast")
factor_speed_vector <- factor(speed_vector, ordered = TRUE, levels = c("slow", "medium", "fast"))

# Factor value for second data analyst
da2 <- factor_speed_vector [2]
da2
# Factor value for fifth data analyst
da5 <- factor_speed_vector [5]

# Is data analyst 2 faster than data analyst 5?
da2>da5


# Definition of vectors
name <- c("Mercury", "Venus", "Earth", 
          "Mars", "Jupiter", "Saturn", 
          "Uranus", "Neptune")
type <- c("Terrestrial planet", 
          "Terrestrial planet", 
          "Terrestrial planet", 
          "Terrestrial planet", "Gas giant", 
          "Gas giant", "Gas giant", "Gas giant")
diameter <- c(0.382, 0.949, 1, 0.532, 
              11.209, 9.449, 4.007, 3.883)
rotation <- c(58.64, -243.02, 1, 1.03, 
              0.41, 0.43, -0.72, 0.67)
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)

# Create a data frame from the vectors
planets_df <- data.frame(name,type,diameter,rotation,rings)
str(planets_df)

# Print out diameter of Mercury (row 1, column 3)
planets_df[1,3]

# Print out data for Mars (entire fourth row)
head(planets_df)
planets_df[4,]

# Select first 5 values of diameter column
head(planets_df,1)
planets_df[1:5,3]

rings_vector <- planet_df[,"rings"]

# Print out rings_vector
rings_vector

# Select the rings variable from planets_df
rings_vector <- planets_df$rings
head(planets_df,1)  
str(planets_df)
# Print out rings_vector
rings_vector
planets_df$name

planets_df[rings_vector, "name"]
planets_df[rings_vector,]

subset(planets_df, subset= diameter<1)

positions <-order(planets_df$diameter) 
positions

# Use order() to create positions
positions <- order(planets_df$diameter)

# Use positions to sort planets_df
planets_df[positions, ]

# Vector with numerics from 1 up to 10
my_vector <- 1:10 

# Matrix with numerics from 1 up to 9
my_matrix <- matrix(1:9, ncol = 3)

# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]

# Adapt list() call to give the components names
my_list <- list(my_vector, my_matrix, my_df)
names(my_list) <- c("vec","mat","df")
# Print out my_list
my_list

# Vector with numerics from 1 up to 10
my_vector <- 1:10 

# Matrix with numerics from 1 up to 9
my_matrix <- matrix(1:9, ncol = 3)

# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]

# Adapt list() call to give the components names
my_list <- list(my_vector, my_matrix, my_df)
names(my_list) <- c("vec","mat","df")
# Print out my_list
my_list

# Print out the vector representing the actors
shining_list$act

# Print the second element of the vector representing the actors
shining_list$act[2]


scores <- c(4.6, 5, 4.8, 5, ___
comments <- c("I would watch it again", "Amazing!", "I liked it", "One of the best m")


linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Popular days
linkedin>15
sum(linkedin>15)
# Quiet days
linkedin<=5

# LinkedIn more popular than Facebook
linkedin>facebook    


linkedin <- c(16, 9, 13, 5, 2, 17, 14)
last <- tail(linkedin, 1)

# Is last under 5 or above 10?
last < 5 | last > 10

# Is last between 15 (exclusive) and 20 (inclusive)?
last > 15 & last <= 20