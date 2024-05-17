library(openair)
st <- Sys.time()
ti <- "1 hour"                         

dt <- seq(from = st, by = ti,length.out = 1000)
ws <- runif(1000,0,20)
wd <- round(runif(1000,0,359))
dat <- data.frame(dt,ws,wd,temp)
windRose(dat)


library(ggplot2)
library(tidyr)
library(dplyr)
library(gcookbook)
ggplot(wind, aes(x = DirCat, fill = SpeedCat)) +
  geom_histogram(binwidth = 15, boundary =100) +
  coord_polar() +
  scale_x_continuous(limits = c(0,360))

library(ncdf4)
newdata <- nc_open("C:/Users/bharg/OneDrive/Desktop/ANT_TB3_Final_Train.nc")
ws <- ncvar_get(newdata,"WS")
temp <-  ncvar_get(newdata,"DBT")
wd <- ncvar_get(newdata,"WD")
fix_t <- as.POSIXct("1901-01-15 00:00:00")
wind_time <- newdata$dim$TAX$vals
n_data <- data.frame(wind_time,ws,wd,temp)
fix_t <- as.POSIXct("1901-01-15 00:00:00")
n_data$date <- fix_t+(n_data$wind_time*3600)
n_data$tempk <- n_data$temp+273
library(openair)
polarFreq(n_data,pollutant = "tempk",statistic = "mean")

ggplot(n_data, aes(x = wd, y = 1)) +
geom_point(shape = 21, size = 5) +
coord_polar()


# Load the required packages
library(ggplot2)

# Create a sample list of directions
directions <- n_data_2003$wd

# Calculate the coordinates for plotting
y <- cos(directions*(pi/180))
x <- sin(directions*(pi/180))

# Create the polar plot
ggplot() +
  geom_point(aes(x, y), size = 2.5)

data_85_89 <- n_data[n_data$date<as.POSIXct("1990-01-01"), ]
data_90_94 <- n_data[as.POSIXct("1989-12-31")<n_data$date & n_data$date<as.POSIXct("1995-01-01"), ]
data_95_99 <- n_data[as.POSIXct("1994-12-31")<n_data$date & n_data$date<as.POSIXct("2000-01-01"), ]
data_00_04 <- n_data[as.POSIXct("1999-12-31")<n_data$date & n_data$date<as.POSIXct("2005-01-01"), ]
data_05_09 <- n_data[as.POSIXct("2004-12-31")<n_data$date & n_data$date<as.POSIXct("2010-01-01"), ]
data_10_14 <- n_data[as.POSIXct("2009-12-31")<n_data$date & n_data$date<as.POSIXct("2015-01-01"), ]


png(width=1920, height = 1415)
for(year in 1985:2010)
{
  year_data <- n_data[n_data$year == year, ]
  polarFreq(year_data,pollutant = "temp",statistic = "mean",type = "season",breaks = seq(-60,30,5),cols = "turbo",fontsize = 30 )

}
dev.off()


png(width=2560, height = 1440)
polarFreq(n_data,pollutant = "temp", statistic = "mean", breaks = seq(-60,30,10),cols = c("navy","darkcyan", "lightblue", "skyblue","yellow","orange","coral","lightcoral","darkred"))
dev.off()


year_data <- n_data[n_data$year == 1990, ]
polarFreq(year_data,pollutant = "temp",statistic = "mean",type = "season",breaks = seq(-60,30,5),cols = "turbo",fontsize = 50)

#################################################################################### temperature   ###############################################################################

avgtemp <- list()
temp_var <- list()
for(year in 1985:2010){
  year_data <- n_data[n_data$year == year, ]
  avgtemp <- c(avgtemp,mean(year_data$temp))
  temp_var <- c(temp_var,var(year_data$temp))
}
t_years <- seq(1985,2010,1)
avgtemp <- as.array(avgtemp)
avgtemp <- as.numeric(avgtemp)
temp_var <- as.array(temp_var)
temp_var <- as.numeric(temp_var)
temp_data <- data.frame(t_years,avgtemp,temp_var)

ggplot(temp_data,aes(t_years,avgtemp))+ geom_point()+theme_bw()
ggplot(temp_data,aes(t_years,temp_var))+ geom_point()+theme_bw()

########################## percentage change#########################
temp_data$per_var <- 0
for(i in 2:26){
  temp_data$per_var[i] <- ((temp_data$temp_var[i]-temp_data$temp_var[i-1])/temp_data$temp_var[i-1])*100
}
ggplot(temp_data,aes(t_years,per_var))+ geom_point()+theme_bw()
ggplot(temp_data,aes(t_years,per_var))+ geom_line()+theme_bw()



##########################################################################

n_data$day <- as.Date(n_data$date)
avgtemp_day <- list()
st <- as.Date("1985-02-26")
et <- as.Date("2010-12-31")
for(date in seq(st,et,by = "day")){
  date_data <- n_data[n_data$day == date, ]
  avgtemp_day <- c(avgtemp_day,mean(date_data$temp))
}

avgtemp_day <- as.array(avgtemp_day)
day_d <- seq(st,et,"day")
data_as_day <- data.frame(day_d,avgtemp_day)

plot(data_as_day$day_d,avgtemp_day)


plot(data_as_day$day_d,avgtemp_day,type = "p",pch = 16)


###########################################################################################

data_as_day$year <- format(data_as_day$day_d,"%Y")
data_as_day$temp_day <- as.numeric(data_as_day$avgtemp_day)

var_ts <- function(data){
  sum = 0
  for(i in 2:length(data)){
    sum = sum + ((data[i] - data[i-1])^2)
  }
  return(sum/(length(data)-1))
}

temp_var_ts <- list()
   
temp_var_ts <- as.numeric(temp_var_ts)
var_ts_data <- data.frame(t_years,temp_var_ts)
ggplot(var_ts_data,aes(t_years,temp_var_ts))+geom_line()

var_ts_data$per_var_ts <- 0
for(i in 2:26){
  var_ts_data$per_var_ts[i] <- ((var_ts_data$temp_var_ts[i]-var_ts_data$temp_var_ts[i-1])/var_ts_data$temp_var_ts[i-1])*100
}
ggplot(var_ts_data,aes(t_years,per_var_ts))+geom_line()

################################################################################################################################

n_data$month <- format(n_data$date,"%m")
variance_per_month <- aggregate(temp ~ month+year, data = n_data, FUN = var_ts)
mean_per_month <- aggregate(temp ~ month+year, data = n_data, FUN = mean)

ggplot(variance_per_month, aes(x = interaction(month, year), y = temp, group = year)) +
  geom_line() +
  geom_point() +
  labs(x = "Month and Year", y = "Variance of Temperature") 


variance_per_month$percentage_variance <- 0
for(i in 2:311){
  variance_per_month$percentage_variance[i] <- ((variance_per_month$temp[i]-variance_per_month$temp[i-1])/variance_per_month$temp[i-1])*100
}

ggplot(variance_per_month, aes(x = interaction(month, year), y = percentage_variance, group = year)) +
  geom_line() +
  geom_point() +
  labs(x = "Month and Year", y = "percentage Variance of Temperature") 

varience_with_month_avg <- aggregate(temp ~ year,data = mean_per_month,FUN = var_ts)
ggplot(varience_with_month_avg,aes(year,varience, group = 1))+ geom_line()

varience_with_month_avg$percentage_varience <- 0
for(i in 2:26){
  varience_with_month_avg$percentage_varience[i] <- ((varience_with_month_avg$temp[i]-varience_with_month_avg$temp[i-1])/varience_with_month_avg$temp[i-1])*100
}

ggplot(varience_with_month_avg,aes(year,percentage_varience, group = 1))+ geom_line()

########################################################################################################################
data_as_day$month <- format(data_as_day$day_d, "%m")

data_as_day$season <- case_when(data_as_day$month %in% c("12","01","02") ~ "winter",
                                data_as_day$month %in% c("03","04","05") ~ "spring",
                                data_as_day$month %in% c("06","07","08") ~ "summer",
                                data_as_day$month %in% c("09","10","11") ~ "autumn",
                                TRUE ~ "unknown")
season_var <- data_as_day %>% group_by(year,season) %>% summarise(var(temp_day),mean(temp_day))
season_var$mean_temp <- season_var$`mean(temp_day)`
season_var_year <- season_var %>% group_by(year) %>% summarize(var(mean_temp))
ggplot(season_var_year,aes(year,seas_vari,group = 1))+geom_line()
season_var_year$seas_vari <- season_var_year$`var(mean_temp)`
season_var_year$percentage_vari <- 0
for(i in 2:26){
  season_var_year$percentage_vari[i] <- ((season_var_year$seas_vari[i]-season_var_year$seas_vari[i-1])/season_var_year$seas_vari[i-1])*100
}
ggplot(season_var_year,aes(year,percentage_vari,group = 1))+geom_line()


#############################################################################################################################





