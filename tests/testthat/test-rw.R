context("test-rw.R")
test_that("NAIVE", {
  fable_fit <- USAccDeaths_tbl %>% model(naive = NAIVE(value))
  forecast_fc <- forecast::naive(USAccDeaths, h = 12)
  
  expect_equivalent(
    fitted(fable_fit)[[".fitted"]],
    unclass(fitted(forecast_fc))
  )
  
  fable_fc <- fable_fit %>% forecast(h = 12)
  
  expect_equivalent(
    fable_fc$value,
    unclass(forecast_fc$mean)
  )
  expect_identical(
    model_sum(fable_fit$naive[[1]]),
    "NAIVE"
  )
})

test_that("RW w/ drift", {
  fable_fit <- USAccDeaths_tbl %>% model(rw = RW(value ~ drift()))
  forecast_fc <- forecast::rwf(USAccDeaths, drift = TRUE, h = 12)
  
  expect_equivalent(
    fitted(fable_fit)[[".fitted"]],
    unclass(fitted(forecast_fc))
  )
  
  fable_fc <- fable_fit %>% forecast(h = 12)
  
  expect_equivalent(
    fable_fc$value,
    unclass(forecast_fc$mean)
  )
  
  expect_equivalent(
    upper(report(fable_fc)$`80%`),
    unclass(forecast_fc$upper[,1])
  )
  
  expect_identical(
    model_sum(fable_fit$rw[[1]]),
    "RW w/ drift"
  )
})

test_that("SNAIVE", {
  fable_fit <- USAccDeaths_tbl %>% model(snaive = SNAIVE(value))
  forecast_fc <- forecast::snaive(USAccDeaths, h = 12)
  
  expect_equivalent(
    fitted(fable_fit)[[".fitted"]],
    unclass(fitted(forecast_fc))
  )
  
  fable_fc <- fable_fit %>% forecast(h = 12)
  
  expect_equivalent(
    fable_fc$value,
    unclass(forecast_fc$mean)
  )
  
  expect_identical(
    model_sum(fable_fit$snaive[[1]]),
    "SNAIVE"
  )
})
