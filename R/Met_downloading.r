library("worldmet")
nfo <- getMeta(lat = 39.1, lon = 117.167)
dat <- importNOAA(code = "545270-99999", year = c(2014,2015,2016,2017,2018,2019,2020))
write.csv(dat, file = "Tianjin.csv", row.names = FALSE)
