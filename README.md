DATA DESCRIPTION:

For this project, we have gathered datasets from Yahoo Finance, for the S&P 500 index, daily gold prices, and Bitcoin prices. Then these datasets are integrated with relevant macroeconomic indicators, including inflation, unemployment, GDP growth rate, GDP, interest rate, and CPI parameters. The data for the economic indicators were taken from the world bank. The World bank provides annual data for all the countries. All the transformations are made in excel.

The data for the asset price is daily while the data for the economic indicators are annually. Some of these indicators are reported annually, while some are reported quarterly. We could also find monthly data for some. To maintain consistency, we chose annual data to be the length of our economic indicators. We also choose annual data as the length because we wanted to capture long term trend and effect and dismiss the short term noise which we would have got if we had chosen monthly and quarterly data. The third reason to go for annual data is because the effect of these parameters are not sudden and it takes time for these to take effect for example interest rates. The effects are not immediate. So by taking annual data, we have taken enough time to account for these effects on the markets.
 
Inflation(GDP Deflator):
Inflation is defined as a prolonged increase in the general price level of goods and services that erodes money's purchasing power. This might be caused by excessive aggregate demand, increased production costs (cost-push inflation), or central bank policy.
Inflation can erode purchasing power, cause economic instability, and amplify income inequality. Central banks combat inflation by raising interest rates, selling government bonds, and increasing reserve requirements. Understanding inflation is critical for making informed decisions about saving and investing.

Unemployment rate:
The unemployment rate is defined as the percentage of the labor force that is actively looking for work but is unable to find it, representing the state of the economy and job availability.The unemployment rate has a substantial impact on financial markets such as stocks, gold, and Bitcoin.High unemployment can lead to lower stock prices as consumer spending and corporate profits decline. Gold often shines in such times due to its safe-haven appeal, while Bitcoin can rise as an alternative investment amidst turmoil.
Low unemployment, on the other hand, could prop up stock prices thanks to increased consumer spending and stronger corporate profits. Gold might lose its luster as economic strength reduces the need for safe havens, while Bitcoin's fate could be mixed based on investor risk appetite and its adoption potential.

GDP growth rate:
The gross domestic product (GDP) growth rate, which measures the percentage change in the total market value of goods and services produced within a country over a specific period, serves as a crucial indicator of economic health and activity. Its influence on the financial market is significant.
Increased economic activity leads to better business earnings, which drives up stock prices and boosts investor confidence. High-growth periods can raise risk appetite, thereby undermining gold's appeal as a haven asset. The link between GDP growth and cryptocurrency prices is complicated and changing.
 
GDP:
Gross domestic product (GDP) represents the total monetary value of all final goods and services produced within a country during a specific period. This critical economic indicator influences a wide range of financial markets, including stocks, gold, and even Bitcoin.
Economic growth fuels stock prices as corporate profits rise, while stagnant economies can lead to downturns. Gold is a safe investment during times of uncertainty, but its demand may wane during strong economic periods. Bitcoin's relationship with GDP is complex and requires further investigation. Understanding these dynamics empowers informed decision-making in the financial market.

Interest rate:
Interest rates, or the cost of borrowing money, are a significant influence in the financial landscape, having enormous effects across a wide range of asset classes. Interest rates influence investment decisions, economic activity, and, ultimately, the functioning of financial markets by changing the cost of lending.
Lower interest rates encourage borrowing and investment, potentially leading to higher business valuations and higher stock prices. Higher rates, on the other hand, discourage borrowing and investment, putting downward pressure on stock prices and necessitating a reconsideration of business values.
Gold is sometimes used as an edge against inflation, with higher interest rates potentially benefiting from inflationary periods. Higher interest rates, on the other hand, promote investment in other asset types, thereby undermining gold's appeal.

CPI:
The Consumer Price Index (CPI) tracks price fluctuations in a basket of products and services commonly purchased by urban consumers. This critical indicator serves as an inflation measure, influencing numerous areas of the financial market.
Rising CPI means increased inflation, which may reduce company profits and discourage investment, potentially resulting in lower stock prices. Gold has traditionally been used to limit inflation, typically profiting from periods of rising CPI because its price rises in accordance with inflation.
 
Closing Price:
The actual dataset had the opening, closing, low and high prices for each record. However we decided to move forward with the closing price instead. The closing price is the value of the last transacted price before the market officially closes for trading. However for Bitcoin, closing price generally refers to the price at 11:59 PM UTC of any given day.

Below, you will find the link to our dataset:

S & P 500:
https://drive.google.com/file/d/1f2C1N6oljg7LKvG47UvyJwX-yPiNmewC/view?usp=sharing

Bitcoin:
https://drive.google.com/file/d/1sDTvOQzfO4GNlKhmhdAHKkp-nODz42Qi/view?usp=shari ng

Gold: https://drive.google.com/file/d/1IZgk4Ektf6E6tySOKRMrVecyaWzTmO2Y/view?usp=sharin g

Data Cleaning
Before using R to build a model that predicts the closing prices of financial markets based on macroeconomic indicators, we cleaned up our data in Excel. We went through each piece of information to make sure it was accurate and consistent. This involved fixing missing or strange values and adjusting the format of the data. We paid special attention to variables like economic indicators and time-related data, ensuring everything was in a standardized and usable form.
After cleaning, we imported the refined data into R for analysis.
 
Methodology:
In this study, we employ Linear Regression, and ARIMA & ETS models to forecast the closing prices of a stock, gold, and Bitcoin. The S&P 500 represents the stock market, the Gold represents the commodity market and Bitcoin represents the cryptocurrency market. Overall, they represent the majority of the financial markets.

Linear Regression
The first model we ran was linear regression. One of the main advantages of linear regression is feature selection. We can see the effect of various independent variables on the target variable (Close) using the Linear Regression. Out of Open, high, close, adjacent close prices, we chose Close price as it is the standard in the financial industry. Below is the analysis of linear regression for various markets:

Linear Regression Results & Findings
We used the forward stepwise regression technique to predict prices. This approach commences with an empty model, gradually incorporating predictor variables while rigorously evaluating their impact on the model's performance. We prioritize the selection of variables that enhance the model while concurrently minimizing the cross-validation (CV)value.

Coefficient Analysis:
S&P 500:
![image](https://github.com/pallavmarch/Impact-of-Macroeconomic-Indicators-on-Financial-Markets/assets/127926908/6d6f281c-73e5-4539-883b-fba54ce5f0a1)

Impact on Stock Price (S&P500):

Equation:

Closing = β0 + β1 Inflation+ β2 Unemployment+β2 Interest rate +β3 GDP growth rate+ β4GDP+ β5CPI

Closing = -1703.29 + 151.22 Inflation -33.83 Unemployment+ 81.49 Interest rate + 58.47 GDP
growth rate+ 0.0000000001959955 GDP -20.94 CPI


The intercept of -1703.29 is the expected stock price when all other factors are zero. Each unit increase in inflation, interest rate, and GDP growth rate is associated with a respective change in the stock price of +151.22, +81.49, and +58.47. GDP's impact is negligible with a coefficient of
+0.0000000001959955. A unit increase in unemployment and CPI leads to a decrease in stock price of -33.83 and -20.94, respectively. Inflation, interest rate, and GDP growth rate have positive relationships with the stock price, while unemployment and CPI have negative relationships.


Bitcoin
![image](https://github.com/pallavmarch/Impact-of-Macroeconomic-Indicators-on-Financial-Markets/assets/127926908/199dc319-3f5c-45f2-b5a8-d1d264eb3b53)
Impact on Bitcoin Price:
Equation
Closing = -140500.00 -6550.00 Inflation+ 7279.00 Unemployment+ +5263.0 GDP growth
rate+ 0.000000005167 GDP+ 5681.00 CPI

The intercept of -140500.00 represents the expected Bitcoin price when all other factors are zero. Each unit increase in unemployment, GDP growth rate, and CPI is associated with a respective change in Bitcoin price of +7279.0, +5263.0, and +5681.0. GDP's impact is negligible with a coefficient of +0.000000005167. A unit increase in inflation leads to a -6550.0 decrease in Bitcoin price. Unemployment, GDP growth rate, and CPI have positive relationships with Bitcoin price, while inflation has a negative relationship.


Gold
![image](https://github.com/pallavmarch/Impact-of-Macroeconomic-Indicators-on-Financial-Markets/assets/127926908/0aaf6b56-d546-4811-8c5c-bc28c36b8242)
Impact on Gold Price:

Equation:

Closing= 2148.15 - 126.00 Unemployment -20.090 Interest rate -93.034 GDP growth rate

The intercept of 2148.15 is the expected gold price when all other factors are zero. A unit increase in Unemployment, Interest rate, and GDP growth rate leads to a decrease in gold price of -126.0, -20.090, and -93.034, respectively. Unemployment, Interest rate, and GDP growth rate negatively correlate with gold price. Inflation, GDP, and CPI don't have an impact on the gold price.

In summary:

	        Stock Price	Bitcoin	  Gold
Intercept	-1703.29	-140500.00	2148.15
Inflation	151.22	-6550.0	0
Unemployment	-33.83	+7279.0	-126.00
Interest_rate	81.49	0	-20.090
GDP_Growth_Rate	58.47	+5263.0	-93.034
GDP	0.0000000001959955	+0.000000005167	0
CPI	-20.94	+5681.0	0

Residual Analysis
We also performed a Residual analysis. Below we will look at the result of the Breusch Godfrey test. The result was similar for all 3 of them:
![image](https://github.com/pallavmarch/Impact-of-Macroeconomic-Indicators-on-Financial-Markets/assets/127926908/dcee720b-14a8-4822-a1a9-4c33b580b07b)

![image](https://github.com/pallavmarch/Impact-of-Macroeconomic-Indicators-on-Financial-Markets/assets/127926908/e0465f5a-8136-4524-b0df-6a7e870ecc0a)
Breusch-Godfrey test for SnP500


![image](https://github.com/pallavmarch/Impact-of-Macroeconomic-Indicators-on-Financial-Markets/assets/127926908/cc8b9a3d-8191-42b5-84ff-47f10047c8b8)
Breusch-Godfrey test for Bitcoin

![image](https://github.com/pallavmarch/Impact-of-Macroeconomic-Indicators-on-Financial-Markets/assets/127926908/7b88bef0-482a-41bd-a1c6-083fd7016363)
Breusch-Godfrey test for Gold

Markets	p values
Stock price	p- value <2.2e-16
Bitcoin price	p- value <2.2e-16
Gold price	p-value <2.2e-16

The p-value from the Breusch-Godfrey test for stock price, bitcoin price, and gold price is the same. A p-value of less than 2.2e-16 in the Breusch-Godfrey test strongly suggests that we can reject the null hypothesis of no autocorrelation in the error term of the model. In simpler terms, this implies strong evidence of autocorrelation in the residuals of our model.

While autocorrelation raises concerns about the validity of the model's statistical inferences and predictions, it does not necessarily negate the existence of a linear relationship between the
 
variables. Therefore, linear regression can still be valuable for exploring and identifying this relationship.

This linear relationship model provides insights into how the macroeconomic indicators influence the stock price, even though it may require further adjustments to address the issue of autocorrelation. These adjustments are made later using the ARIMA model.


Time Series Regression- ARIMA:
A time series is a collection of data items indexed in time order. Time series regression is a statistical technique used to forecast and analyze time series. It simulates the relationship over time between one or more independent variables—the variables you are using to generate the prediction—and a dependent variable, the variable you are trying to predict. These variables may include historical values of the dependent variable, other pertinent time series, or even extraneous variables such as meteorological or holiday conditions.

ARIMA Process:

ARIMA stands for Autoregressive Integrated Moving Average. It's a statistical method for analyzing and forecasting time series data

We will now utilize the ARIMA model to analyze and forecast the closing prices of the S&P 500, Gold, and Bitcoin. The processes below have been repeated for all of them: S&P 500, Gold, and Bitcoin. However, the images represent the S & P 500 for reference.
Step 1: Transformations:

In our data analysis process, we applied Box-Cox and log transformations as crucial techniques to address issues related to heteroscedasticity, or unequal variance, which is a common challenge in statistical modeling. The Box-Cox transformation is a power transformation method that optimizes the normality and homoscedasticity of the residuals. By identifying the lambda parameter that maximizes the log-likelihood, Box-Cox ensures that the transformed data exhibit constant
 
variance. Similarly, the log transformation involves taking the natural logarithm of the data, which is particularly effective in stabilizing variance and making it more uniform across the range of observations.
![image](https://github.com/pallavmarch/Impact-of-Macroeconomic-Indicators-on-Financial-Markets/assets/127926908/d8f5b65a-7dcf-49b7-a8b5-4c5f12106a2e)

Step 2: Unit Root Test

In the Augmented Dickey-Fuller (ADF) test, the null hypothesis posits the presence of a unit root, indicating non-stationarity in time series data. Failure to reject the null suggests the data is likely non-stationary. Conversely, rejecting the null provides evidence of stationarity, indicating the absence of a unit root. Stationarity is crucial in time series analysis, as many statistical methods and models assume or require stationary data. In our case, with one differencing, rejecting the null implies that the differenced data is stationary, facilitating more reliable analyses and model applications
![image](https://github.com/pallavmarch/Impact-of-Macroeconomic-Indicators-on-Financial-Markets/assets/127926908/8bb75ba9-8d04-4a35-b3cf-8c0bceb925c3)






