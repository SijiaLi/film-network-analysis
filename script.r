library(plyr)

sample <- filmnetwork[1:50000, c(1,4)]
head(sample)
head(unique(sample$User_ID))
#370 372 387 407 413 425
length(unique(sample$User_ID))
#32114
length(unique(sample$Movie_ID))
#5

#for the user of User_ID == 1
tmp1 <- subset(sample, User_ID == 1)
head(tmp1)
# the user of user id = 1, watched 2 movies, which are NO. 4 and NO. 5. we need 4 and 5 as a row in our data frame
df <- matrix(4:5, 1, 2)

tmp2 <- subset(sample, User_ID == 413)
# the user of user id = 413 watched 4 movies, which are NO. 1, 2, 4, 5. We need 1-2, 1-4, 1-5, 2-4, 2-5, 4-5 in our dataset
x <- tmp2$Movie_ID
y <- t(combn(x,2))
#now rbind to the v1v2 df of ours
df <- rbind(df, y)
#now df is a data frame of 2 users



#how large is our dataset?
h <- as.data.frame(table(filmnetwork$User_ID))
head(h,20)
#user id = 1 DE REN watched 9 movies in total, 
hist(table(filmnetwork$User_ID))
#you 40000 ren yi bu dou mei kan
head(subset(h, Freq == 1))
nrow(subset(h, Freq ==1))
#6723 ppl only watched one, so they're not gonna be in our analysis
nrow(subset(h, Freq ==2))
#6475
nrow(subset(h, Freq ==3))
#5398

#seems not that large workload

valid.user <- subset(h, Freq > 1)
valid.user <- as.vector(valid.user[,1])
data <- subset(filmnetwork, User_ID %in% valid.user)
data <- data[c(1,4)]
# not reduced dramatically..

# first get the users with 2 movies
df <- matrix(NA,1,2)
for (i in 1:49537) {
  ds <- subset(data, User_ID == valid.user[i])
  x <- ds$Movie_ID
  y <- t(combn(x,2))
  df <- rbind(df, y)
}

df.backup <- df
df <- data.frame(df)
names(df) <- c("a", "b")
withrows <- ddply(df,.(a,b),nrow)

#what if we define common of 500 as "strong" and deserves a string
#that is to say, if more than 500 people have viewed the same two movies, draw a line between these two movies
test <- subset(withrows, V1 >= 5000)
test <- test[1:2]
g <- graph.data.frame(test, directed = "FALSE")
plot(g)
vcount(g)

