#Impact of MacroEconomic Indicators on the Financial Markets

# the file contains the code for 1. S&P500 2. Bitcoin 3. Gold

# The first part is Linear Regression & second part is Time series Regression & ARIMA



# The Stock Market- S&P 500
library(fpp2)

SnP500  #importing the dataset from the project report Data Decription link


df= ts(SnP500)
df

#Exploratory data analysis

autoplot(df[,"Close"])
autoplot(df[,"Volume"])
autoplot(df[,"Inflation"])
autoplot(df[,"Unemployment"])
autoplot(df[,"GDP_Growth_Rate"])
autoplot(df[,"Interest_rate"])
autoplot(df[,"GDP"])
autoplot(df[,"CPI"])


#Linear Regression


# testing models

m1 = tslm( Close ~ Inflation, df)
summary(m1)

m2 = tslm( Close ~ Inflation + Unemployment, df)
summary(m2)

m3 = tslm( Close ~ Inflation + Unemployment+Interest_rate, df)
summary(m3)

m4 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate, df)
summary(m4)

m5 = tslm( Close ~ Inflation +Interest_rate + CPI, df)
summary(m5)

m6 = tslm( Close ~ Inflation + GDP_Growth_Rate+Interest_rate, df)
summary(m6)

m7 = tslm( Close ~ Inflation + GDP_Growth_Rate, df)
summary(m7)

m8 = tslm( Close ~ Inflation + GDP_Growth_Rate+Unemployment, df)
summary(m8)

m9 = tslm( Close ~ Inflation + GDP_Growth_Rate+CPI, df)
summary(m9)

m10 = tslm( Close ~ CPI+ GDP_Growth_Rate, df)
summary(m10)

m11 = tslm( Close ~ GDP_Growth_Rate+Unemployment, df)
summary(m11)

m12 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ GDP, df)
summary  #best model

m13 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ CPI, df)
summary(m13)

m14 = tslm( Close ~ Inflation + Unemployment+Interest_rate+CPI, df)
summary(m14)

m15 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ CPI, df)
summary(m15)

m16 = tslm( Close ~ Inflation + Unemployment+CPI+GDP_Growth_Rate, df)
summary(m16)

m17 = tslm( Close ~ Inflation + CPI+Interest_rate+GDP_Growth_Rate, df)
summary(m17)

m18 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ GDP+ CPI, df)
summary(m18)  # best model

m19 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ CPI, df)

m20 = tslm( Close ~ Inflation + Unemployment+CPI+GDP_Growth_Rate+ GDP, df)

m21 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ CPI, df)


#Model Evaluation- Cross Validation

CV(m1)
CV(m2)
CV(m3)
CV(m4) #  3.52
summary(m4)
CV(m5)
CV(m6)
CV(m7)
CV(m8)
CV(m9)
CV(m10)
CV(m11)
CV(m12)  #1.012343
CV(m13) #3.50
CV(m14)
CV(m15)  #3.50
CV(m16)
CV(m17)
CV(m18) #1.0115   best model
summary(m18)
CV(m19)
CV(m20) #1.07
CV(m21)



# same above best model presented properly
best_model = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ GDP+ CPI, df)
summary(best_model)  # best model
CV(best_model)

#Coefficients:
# Estimate Std
#(Intercept)     -1703.2910138615925462     
# Inflation       151.2220062640650724  
#Unemployment    -33.8301221710670177  
#Interest_rate   81.4893687317296838  
#GDP_Growth_Rate  58.4659432939163963
#GDP               0.0000000001959955 
#CPI              -20.9364747381814738 

checkresiduals(best_model)  #  p value is low- null rejected- evidence for serial correlation


## now for time series regression- ARIMA

price= df[,'Close']
price
tail(price)
autoplot(price)

ggtsdisplay(price)

#transformations
lamb = BoxCox.lambda(price)
autoplot(cbind(price,log(price),BoxCox(price,lamb)),facets = T) # boxcox is better

ndiffs(BoxCox(price,lamb)) # 1
nsdiffs(BoxCox(price,lamb))  # no seasonality as annual data

#checking for unit roots

library(urca)


ur.df(BoxCox(price,lamb),type = "trend",lags = 22)%>%summary  # not rejected
ur.df(diff(BoxCox(price,lamb)),type = "trend",lags = 22)%>%summary # null rejected

# differencing = 1

#Finding initial model

mod1 = Arima(price, order = c(1,1,1),lambda = jLam)
summary(mod1)

mod2 = Arima(price, order = c(9,1,9),lambda = jLam)
summary(mod2)  
checkresiduals(mod2)

mod3 = Arima(price, order = c(9,1,10),lambda = jLam)
summary(mod3) # best model -44712
checkresiduals(mod3)

mod4 = Arima(price, order = c(9,1,16),lambda = jLam)  
summary(mod4)  
checkresiduals(mod4)

mod5 = Arima(price, order = c(10,1,10),lambda = jLam)
summary(mod5)
checkresiduals(mod5)

mod6 = Arima(price, order = c(4,1,4),lambda = jLam)
summary(mod6)
checkresiduals(mod6)

#forecasting

## Auto ARIMA recommended model
recommended_model= auto.arima(price, d=1, lambda = jLam)  
recommended_model 
checkresiduals(recommended_model)

fc1= forecast(recommended_model, h = 100)
fc1
autoplot(fc1)  # the auto arima recommended model forecast

fc2= forecast(mod3, h = 100)
fc2  # our model
autoplot(fc2)

#ETS Forecast
ets_suggested_model= ets(price)
ets_suggested_model


fc3= forecast(ets_suggested_model, h = 100)
fc3
autoplot(fc3)


#Plotting all the forecast
autoplot(window(price,start=2010))+
  autolayer(fc1,series = "ARIMA",PI=F)+  # with recommended auto arima model
  autolayer(fc3,series = "ETS",PI=F)+
  autolayer(fc2,series = "OUR MODEL",PI=F)  # our model





## Bitcoin

Bitcoin    # Please import the Bitcoin dataset from the project report Data Decription link

df= ts(Bitcoin)
df
#Exploratory data analysis

autoplot(df[,"Close"])
autoplot(df[,"Volume"])
autoplot(df[,"Inflation"])
autoplot(df[,"Unemployment"])
autoplot(df[,"GDP_Growth_Rate"])
autoplot(df[,"Interest_rate"])
autoplot(df[,"GDP"])
autoplot(df[,"CPI"])


#Linear Regression

#Modelling
m1 = tslm( Close ~ Inflation + Unemployment+CPI, df)

m2 = tslm( Close ~ Inflation + Unemployment, df)

m3 = tslm( Close ~ Inflation + Unemployment+Interest_rate, df)

m4 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate, df)

m5 = tslm( Close ~ Inflation +Interest_rate, df)

m6 = tslm( Close ~ Inflation + GDP_Growth_Rate+Interest_rate, df)

m7 = tslm( Close ~ Inflation + GDP_Growth_Rate, df)

m8 = tslm( Close ~ Inflation + GDP_Growth_Rate+Unemployment, df)

m9 = tslm( Close ~ Inflation + GDP_Growth_Rate+Unemployment, df)

m10 = tslm( Close ~ GDP_Growth_Rate, df)

m11 = tslm( Close ~ GDP_Growth_Rate+Unemployment, df)

m12 = tslm( Close ~  Unemployment+Interest_rate+GDP_Growth_Rate+ GDP + CPI, df)

m13 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate + CPI, df)

m14 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ GDP, df)

m13 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ CPI, df)

m14 = tslm( Close ~ Inflation + Unemployment+Interest_rate+CPI, df)

m15 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ CPI, df)

m16 = tslm( Close ~ Inflation + Unemployment+CPI+GDP_Growth_Rate, df)

m17 = tslm( Close ~ Inflation + CPI+Interest_rate+GDP_Growth_Rate, df)

m18 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ GDP+ CPI, df)

m19 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ CPI, df)

m20 = tslm( Close ~ Inflation + Unemployment+CPI+GDP_Growth_Rate+ GDP, df) #best model

m21 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate, df)

#Model Evaluation- Cross Validation


CV(m1)
CV(m2)
CV(m3)
CV(m4) 
CV(m5)
CV(m6)
CV(m7)
CV(m8)
CV(m9)
CV(m10)
CV(m11)
CV(m12) 
CV(m13)
CV(m14)
CV(m15)
CV(m16)
CV(m17)
CV(m18) #3.1094
CV(m19)  
CV(m20)  #3.1089  best model
CV(m21)

# # same above best model presented properly

best_model = tslm( Close ~ Inflation + Unemployment+CPI+GDP_Growth_Rate+ GDP, df) 
CV(best_model) #3.1089
summary(best_model)

#Coefficients:
# Estimate 	Std. Error 		t value   Pr(>|t|)    
#(Intercept)     -1.405e+05  2.460e+03  -57.09   <2e-16 ***
# Inflation       -6.550e+03  4.643e+02  -14.11   <2e-16 ***
#Unemployment     7.279e+03  1.117e+02   65.17   <2e-16 ***
#CPI              5.681e+03  3.821e+02   14.87   <2e-16 ***
#GDP_Growth_Rate  5.263e+03  6.974e+01   75.46   <2e-16 ***
#GDP              5.167e-09  1.382e-10   37.38   <2e-16 ***


checkresiduals(best_model) # p value low- evidence for serial correlation
# cannot use it


## Time series regression- ARIMA

price= df[,'Close']
price
tail(price)
autoplot(price)

#transformations

jLam = BoxCox.lambda(price)
autoplot(BoxCox(price,jLam))
autoplot(cbind(price, log(price),BoxCox(price,jLam)),facets = T)

nsdiffs(BoxCox(price,jLam))  # non seasonal data
ndiffs(BoxCox(price,jLam))  # 1
#4
ggtsdisplay(diff(BoxCox(price,jLam))) # we need one differencing

##Finding initial model


mod1 = Arima(price, order = c(6,1,6),lambda = jLam)
summary(mod1)   #-10204.91            best model
checkresiduals(mod1)  #0.62 p value

mod2 = Arima(price, order = c(10,1,10),lambda = jLam)
summary(mod2)
checkresiduals(mod2)  # low p vALUE

mod3 = Arima(price, order = c(3,1,3),lambda = jLam)
summary(mod3)
checkresiduals(mod2)  # low p vALUE

mod4 = Arima(price, order = c(4,1,3),lambda = jLam)
summary(mod4)
checkresiduals(mod4)   # low p vALUE

#forecasting

fc1= forecast(mod1, h = 100)
fc1
autoplot(fc1)  # our model


## Auto arima -recommended model
recommended_model= auto.arima(price, d=1, lambda = jLam)  #2,1,3
recommended_model  #-10209
checkresiduals(recommended_model)

fc2= forecast(recommended_model, h = 100)
fc2
autoplot(fc2)  # the auto arima way

#ETS  Model
ets_suggested_model= ets(price)
ets_suggested_model

fc3= forecast(ets_suggested_model, h = 100)
fc3
autoplot(fc3)


#All the forecast
autoplot(price)+
  autolayer(fc1,series = "OUR ARIMA",PI=F)+
  autolayer(fc2,series = "AUTO ARIMA",PI=F)+
  autolayer(fc3,series = "ETS",PI=F)




# Gold

Gold    # Please import the dataset from the project report Data Decription link

df= ts(Gold)
df

#Exploratory data analysis

autoplot(df[,"Close"])
autoplot(df[,"Inflation"])
autoplot(df[,"Unemployment"])
autoplot(df[,"GDP_Growth_Rate"])
autoplot(df[,"Interest_rate"])
autoplot(df[,"GDP"])
autoplot(df[,"CPI"])

#Linear Regression

# testing models

m1 = tslm( Close ~ Inflation, df)
summary(m1)

m2 = tslm( Close ~ Inflation + Unemployment, df)
summary(m2)

m3 = tslm( Close ~ Inflation + Unemployment+Interest_rate, df)
summary(m3)

m4 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate, df)
summary(m4) #best model

m5 = tslm( Close ~ Inflation +Interest_rate, df)
summary(m5)

m6 = tslm( Close ~ Inflation + GDP_Growth_Rate+Interest_rate, df)
summary(m6)

m7 = tslm( Close ~ Inflation + GDP_Growth_Rate, df)
summary(m7)

m8 = tslm( Close ~ Inflation + GDP_Growth_Rate+Unemployment, df)
summary(m8)

m9 = tslm( Close ~ Inflation + GDP_Growth_Rate+Unemployment, df)
summary(m9)

m10 = tslm( Close ~ GDP_Growth_Rate, df)
summary(m10)

m11 = tslm( Close ~ GDP_Growth_Rate+Unemployment, df)
summary(m11)

m12 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ GDP + CPI, df)
summary(m12)

m13 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate + CPI, df)
summary(m13)

m14 = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate+ GDP, df)
summary(m14)

#Model Evaluation- Cross Validation

CV(m1)
CV(m2)
CV(m3)
CV(m4) # best model 1.27
summary(m4)
CV(m5)
CV(m6)
CV(m7)
CV(m8)
CV(m9)
CV(m10)
CV(m11)
CV(m12)
CV(m13)
CV(m14)

#### same above best model presented properly

best_model = tslm( Close ~ Inflation + Unemployment+Interest_rate+GDP_Growth_Rate, df)
summary(best_model)
CV(best_model)  #1.28

#Coefficients:
#Estimate         Std. Error t value Pr(>|t|)    
#(Intercept)     2148.154     29.854  71.955  < 2e-16 ***
# Inflation       -126.012     10.025 -12.570  < 2e-16 ***
#Unemployment     -20.090      3.398  -5.913 3.57e-09 ***
#Interest_rate   -225.920      5.471 -41.294  < 2e-16 ***
#GDP_Growth_Rate  -93.034      3.260 -28.538  < 2e-16 ***

checkresiduals(best_model)


# so based on p value, we have  evidence for serial corelation which means we cannot use this model
# the residual plot also suggest the same

## Time series regression- ARIMA
#ARIMA

price= df[,'Close']
price

autoplot(price)

#transformations


jLam = BoxCox.lambda(price)
autoplot(BoxCox(price,jLam))
autoplot(cbind(price, log(price),BoxCox(price,jLam)),facets = T)


nsdiffs(BoxCox(price,jLam))  # non seasonal data
ndiffs(BoxCox(price,jLam))  # 1   # using this instead of Unit root method

#AUTO ARIMA
recommended_model= auto.arima(price, d=1, lambda = jLam)  #0,1,0
recommended_model  #-40445
checkresiduals(recommended_model)  # low p value= model rejected
ggtsdisplay(diff(price), lambda= jLam)

##Finding initial model

mod1 = Arima(price, order = c(1,1,1),lambda = jLam)
summary(mod1)

mod2 = Arima(price, order = c(1,1,0),lambda = jLam)
summary(mod2)

mod3 = Arima(price, order = c(0,1,1),lambda = jLam)
summary(mod3)

mod4 = Arima(price, order = c(9,1,9),lambda = jLam)  
summary(mod4)  # best model -40449
checkresiduals(mod4)  # sufficient p value  # model selected

mod5 = Arima(price, order = c(5,1,5),lambda = jLam)
summary(mod5)

mod6 = Arima(price, order = c(4,1,4),lambda = jLam)
summary(mod6)

#hence best model

best_model = Arima(price, order = c(9,1,9),lambda = jLam)  
summary(best_model)  # best model -40449
checkresiduals(best_model)  # sufficient p value  # model selected

# forecasting

fc1= forecast(recommended_model, h = 100)  # auto arima
fc1
autoplot(fc1)

fc2= forecast(best_model, h = 100)  #our model
fc2
autoplot(fc2)

#ETS Model
ets_suggested_model= ets(price)
ets_suggested_model  #(MAN)

fc3= forecast(ets_suggested_model, h = 100)
fc3
autoplot(fc3)


#Final comparison

autoplot(price)+
  autolayer(fc1,series = "Auto ARIMA",PI=F)+ 
  autolayer(fc2,series = "Our ARIMA",PI=F)+   # final forecast
  autolayer(fc3,series = "ETS",PI=F)
