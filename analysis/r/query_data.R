#-------------------------------------------------------------------------------
# Description:
# Inputs:
# Outputs:
#-------------------------------------------------------------------------------

# Load Libraries
suppressPackageStartupMessages(library(odbc))
# suppressPackageStartupMessages(library(ROracle))
suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(dplyr))

# Custom functions
nowt <- function(x = NULL) x

# Load Configuration
if(file.exists(here::here("k:/config.sh"))) readRenviron(here::here("k:/config.sh"))
if(file.exists(here::here("settings.sh"))) readRenviron(here::here("settings.sh"))

# Connect to database)
con_apsd <- DBI::dbConnect(odbc::odbc(),
                           dsn = Sys.getenv("apsd_uid"),
                           uid = Sys.getenv("apsd_uid"),
                           pwd = Sys.getenv("apsd_pwd"))

# Get Data
rs <- DBI::dbSendQuery(con_apsd, read_file(here::here("analysis", "sql", "template.sql")))
df <- DBI::dbFetch(rs) %>%
  rename_all(.funs = tolower)


# Disconnect
DBI::dbDisconnect(con_apsd)
