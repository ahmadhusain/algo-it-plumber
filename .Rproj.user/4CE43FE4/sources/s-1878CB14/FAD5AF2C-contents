library(plumber)
library(tidyverse)
library(tidymodels)
library(jsonlite)
library(caret)

#* @apiTitle Internal training

#* Prediksi data baru
#* @post /api-predict
function(req) {
  
  
  # preprocess data
  
  unseen_data <- fromJSON(req$postBody) %>% as_tibble()

  obs <- nrow(unseen_data)
  
  bank <- read.csv("telemarketing/bank-sub.csv", stringsAsFactors = T)
  bind_data <- bank %>% 
    bind_rows(unseen_data)
  
  
  dmy <- dummyVars(" ~ .", data = bind_data)
  unseen_boost <- data.frame(predict(dmy, newdata = bind_data))
  
  unseen_boost <- unseen_boost %>% 
    select(-yno) %>% mutate(yyes = as.factor(yyes))
  
  colnames(unseen_boost) <- readRDS("telemarketing/colnames.RDS")
  
  # predict
  
  final_model <- readRDS("telemarketing/best_model.Rds")
  
  prediction <- predict(final_model[[1]], newdata = unseen_boost %>% tail(obs))
  
  ifelse(prediction == 1, "yes", "no")
}


