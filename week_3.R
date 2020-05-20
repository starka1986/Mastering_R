download.file('http://bit.ly/CEU-R-ecommerce','ecommerce.zip', mode = 'wb')
unzip('ecommerce.zip')
library(dbr)
options('dbr.db_config_path' = 'week3.yaml')
options('dbr.output_format' = 'data.table')
# storing in the background
# options is a way to store configs in the global namespace for your packages and other options

sales <- db_query('SELECT * FROM sales', 'ecommerce')
str(sales)
db_refresh(sales)

# where did we change global options


sales[, sample(InvoiceDate, 25)]
sales[, InvoiceDate := as.POSIXct(InvoiceDate, format = '%m/%d/%Y %H:%M') ]
str(sales)

# lubridate version
library(lubridate)
?mdy
?mdy_hms
#mdy_hms('')

sales2 <- strptime(sales, "%d/%m/%Y %H:%M", tz = "Europe/London")
str(sales2)
sales3 <- strptime(sales$InvoiceDate, "%d/%m/%Y %H:%M", tz = "Europe/London")
str(sales3)

## Compute the number of rows per month

sales[, .N, by= .(month =as.character(InvoiceDate, format = '%Y %m'))]

# lubridate helper functions

sales[, .N, by =month(InvoiceDate)]
sales[, .N, by = year( InvoiceDate)]
sales[, .N, by= paste(year(InvoiceDate), month(InvoiceDate))]

# now function in lubridate
# tzone argument

now(tzone= 'Europe/Budapest')
Sys.getlocale()
Sys.getenv()

sales[, .N, by = floor_date(InvoiceDate, 'month')]

## TODO invoice summary: invoice number, customer, country, date, value

invoice <- sales[, . ()]
invoice <- sales[, summary(InvoiceNo,CustomerID,Country,Quantity), by="InvoiceDate"]
invoice

invoice <- sales[, lapply(.SD, sum, na.rm=TRUE), by="Quantity" ]
invoices <- sales[, .(date = min(as.Date(InvoiceDate)), 
                     value = sum(Quantity * UnitPrice)),
                 by = .(invoice = InvoiceNo, customer = CustomerID, country = Country)]
str(invoices)

db_insert(invoices, 'invoices', 'ecommerce')

invoices <- db_query('SELECT * FROM invoices', 'ecommerce')

str(invoices)
invoices[, date := as.Date(date, origin = '1970-01-01')] # this is what I needed yesterday
str(invoices)

# reporting to Excel spreadsheet on daily revenue
revenue <- invoices[, .(revenue = sum(value)), by = date]
str(revenue)

library(openxlsx)
wb <- createWorkbook()
sheet <- 'Revenue'
# record sheet name to a variable
addWorksheet(wb, sheet)
writeData(wb, sheet, revenue)
openXL(wb)

# add a few things so it looks nicer

freezePane(wb, sheet, firstRow = TRUE)

# style that renders currencies with pound

poundstlye <- createStyle(numFmt= '$0,000.00')

addStyle(wb, sheet, poundstlye,
         cols = 2, rows = 1:nrow(revenue), 
         gridExpand = TRUE, stack = TRUE)

filename <- 'report.xlsx'

saveWorkbook(wb, filename, overwrite = TRUE)

# now written to disc, and see in files panel