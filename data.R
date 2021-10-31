# Isometric resistance training effect on blood pressure
irt <- read.table(header = T, text = "
studyID n.e mean.e sd.e n.c mean.c sd.c
Goessler,2018 22 5.5 8.46 16 1 6.94
Ogbutor,2019 200 -7.47 1.69 200 -4.07 2.61
Taylor,2019 24 -12.3 4.38 24 0.3 4.02
Gordon-Home,2018 9 -9.7 10.2 2 -2.3 9.39
Worachet,2017 21 -4.23 4.64 21 0.83 3.64
Carlson,2016 18 -7 10.82 20 -2 12.04
Gordon-Lab,2018 8 -9.1 11.6 3 -2.3 9.39
Baross-8MVC,2012 10 -0.8 4.37 5 -0.2 3.26
Ritti-Dias,2017 15 -8 11.09 16 0 11.4
Baross-14MVC,2012 10 -10.8 5.88 5 -0.2 3.26
Ahmed,2019 20 -18.75 8.45 20 -13 9.54
Baross,2013 10 -11 8 10 -0.1 4
Forjaz,2019 8 -3 8.19 8 5 12.93
Pagonas,2017 24 0.01 14.6 25 1.4 17.6
Farah-Lab,2018 13 -9 13.55 8 -6 16.16
Stiller-Moldovan,2012 11 -1.1 8.82 9 5.2 10.94
Farah-Home,2018 17 -4 12.13 8 -6 12.39
Morrin,2018 9 6.1 9 8 -2.4 6
Badrov,2013 12 -8 12.39 12 1 13.59
Okamoto,2019 11 -17 9.73 11 -2 8.19
Correia,2020 50 -2 16.75 52 -3 17.33
Gregory,2012 5 -10 12.87 3 -4 15.72
Yoon,2019 17 -8.9 8.9 18 -2.3 7.6
Taylor,2003 9 -19 6.82 8 -8 8.44
Herrod,2020 11 -9 9 12 -1 6
Punia,2020 20 -5.75 3.96 20 3 2.96
Wiley,1992 8 -12.7 2.73 7 2.6 7.45
")

# Add age group
irt$age_gp <- c(rep(">65", 8), rep("<65", 19))
