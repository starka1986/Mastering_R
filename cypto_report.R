library(binancer)
library(lubridate)
library(jsonlite)
library(httr)
library(logger)
prices <- binance_ticker_all_prices()
prices[from == 'BTC' & to == 'USDT', price]

binance_coins_prices() [symbol == 'BTC', usd]

#print(paste0('Value of .42 Bitcoins is $', round(0.42 * binance_coins_prices()[symbol == 'BTC']$usd, 2)))

# get url

readLines('https://api.exchangeratesapi.io/latest?base=USD') 

# parse json
# could use only JSONlite fromJSON no need for readLines


usdhuf

# getting current bitcoin price and converting 
## this is where the real stuff starts

# create a constant on top

BITCOINS <-0.42 
log_info('Number of Bitcoins: {BITCOINS}') # glue package


get_bitcoin_price <- function() {
  tryCatch( binance_coins_prices() [symbol == 'BTC', usd],
            error= function(e) get_bitcoin_price()  )
}

get_bitcoin_price()


btcusdt <- get_bitcoin_price()
log_info('The value of 1 Bitcoin in USD : {btcusdt}')

# create object for huf conversion
usdhuf <- fromJSON('https://api.exchangeratesapi.io/latest?base=USD&symbola=HUF')$rates$HUF


BITCOINS * btcusdt * usdhuf

