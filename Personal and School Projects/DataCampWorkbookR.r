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