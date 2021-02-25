# run_api.R
library(plumber)
plumb(file = "plumber.R")$run(port = 8000)