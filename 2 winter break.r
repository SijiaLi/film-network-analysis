setwd("~/Desktop/Projects/filmnetwork/Dec 16")
library(reshape2)
load("filmnetwork_newdata.rdata")

getdf <- function(x) {
  s <- split(x, x$user)
  df <- sapply(s, function(x) mean(x$Rating))
  df <- data.frame(df)
  df <- data.frame(user = rownames(df), avgrating = df$df)
  df <- merge(df, user_membership, by = "user")
  df$rating.group <- NA
  df$rating.group[df$avgrating > 0] <- "greater than 0"
  df$rating.group[df$avgrating > 1] <- "greater than 1"
  df$rating.group[df$avgrating > 2] <- "greater than 2"
  df$rating.group[df$avgrating > 3] <- "greater than 3"
  df$rating.group[df$avgrating > 4] <- "greater than 4"

  t <- table(df$rating.group, df$membership)
  pt <- prop.table(t,1)
  t <- as.data.frame(t)
  t <- dcast(t, Var1~Var2, value.var="Freq")
  t$num <- rowSums(t[-1])
  
  pt <- as.data.frame(pt)
  pt <- dcast(pt, Var1~Var2, value.var = "Freq")
  pt[,-1] <- round(pt[,-1],3)
  names(pt)[1] <- "rating"
  names(pt)[-1] <- paste0("community", names(pt)[-1])
  pt$num <- t$num
  pt
}

getdf(newdata_d)
getdf(newdata_f)
getdf(newdata_p)
