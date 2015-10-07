activity <- read.csv("activity.csv")

library("plyr")
activity1 <- ddply(activity, .(date), summarise, sum_steps=sum(steps, na.rm=TRUE))
activity2 <- ddply(activity, .(interval), summarise, average=mean(steps, na.rm=TRUE))


hist(activity1$sum_steps, main="Steps Per Day Histogram", xlab="# of steps")

Table:
act_mean <- mean(activity1$sum_steps, na.rm=TRUE)
act_median <- median(activity1$sum_steps, na.rm=TRUE)


plot(activity2$interval, activity2$average, type="l", xlab="Time (5 min interval)", ylab="Average daily # of steps")
max_interval <- activity2$interval[which.max(activity2$average)]

activity <- merge(activity2,activity)

activity$steps[is.na(activity$steps)] <- activity$average[is.na(activity$steps)]
activity1 <- ddply(activity, .(date), summarise, sum_steps=sum(steps, na.rm=TRUE))

hist(activity1$sum_steps, main="Steps Per Day Histogram", xlab="# of steps")

act_mean <- mean(activity1$sum_steps, na.rm=TRUE)
act_median <- median(activity1$sum_steps, na.rm=TRUE)


activity$weekday <- as.factor(ifelse(weekdays(as.Date(activity$date)) %in% c("Saturday", "Sunday"), "weekend","weekday"))
activity2 <- ddply(activity, .(interval, weekday), summarise, average=mean(steps, na.r=TRUE))


library(lattice)
xyplot(average ~ interval | weekday,data = activity2, layout=c(1,2),type="l", xlab="Time (5 min interval)", ylab="Average daily # of steps")

