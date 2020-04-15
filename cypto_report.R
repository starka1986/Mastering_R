library(binancer)
library(lubridate)
library(jsonlite)
library(httr)
prices <- binance_ticker_all_prices()
prices[from == 'BTC' & to == 'USDT', price]

binance_coins_prices() [symbol == 'BTC', usd]

print(paste0('Value of .42 Bitcoins is $', round(0.42 * binance_coins_prices()[symbol == 'BTC']$usd, 2)))

# get url

readLines('https://api.exchangeratesapi.io/latest?base=USD') 

# parse json
# could use only JSONlite fromJSON no need for readLines

usdhuf <- fromJSON('https://api.exchangeratesapi.io/latest?base=USD&symbola=HUF')$rates$HUF
usdhuf

# getting current bitcoin price and converting 


0.42 * binance_coins_prices() [symbol == 'BTC', usd] * fromJSON('https://api.exchangeratesapi.io/latest?base=USD&symbola=HUF')$rates$HUF

