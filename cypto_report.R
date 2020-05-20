library(binancer)
library(lubridate)
library(jsonlite)
library(httr)
library(logger)
library(checkmate)
library(scales)
log_threshold(TRACE)
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


get_bitcoin_price <- function(retried = 0) {
  tryCatch( binance_coins_prices() [symbol == 'BTC', usd],
            error= function(e) {
              ## exponential backoff retries
              Sys.sleep(1 + retried^2)
              get_bitcoin_price(retried = retried + 1)  
              })
}

get_bitcoin_price()

forint <-  function(x) {
  dollar(x, prefix = '', suffix = 'Ft')
  
}

#source{utils.R}

btcusdt <- get_bitcoin_price()
log_info('The value of 1 Bitcoin  : {dollar(btcusdt)}')
#log_eval(btcusdt)
assert_number(btcusdt, lower = 1000)



# create object for huf conversion
usdhuf <- fromJSON('https://api.exchangeratesapi.io/latest?base=USD&symbola=HUF')$rates$HUF
log_info('The value of 1 USD: {forint(usdhuf)}')
#log_eval(usdhuf)
assert_number(usdhuf, lower = 250, upper = 500)

log_eval(forint(BITCOINS * btcusdt * usdhuf)) ##TODO formatting ( use space around operators and after comma)

