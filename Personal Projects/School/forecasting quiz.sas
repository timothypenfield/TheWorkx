/****** STEP 1:  IDENTIFY  **********/
/*  analyze total monthly units sold */
/*  Is the series white noise? (Ljung-Box test) */
/*  Is the series stationary? (ADF test) */
/*  What value of p, d, q should I choose  (ACF, PACF) */
libname alldata 'C:/Users/timot/Dropbox/Educational/MSBA/BAN7070 Time Series Forecasting/Take Home Quiz';
proc arima data = alldata.steel ;
  identify var = export nlag=24 stationarity=(ADF=(0));
run ;

/****** STEP 2:  ESTIMATE ***********/
/*  Start with an AR(1) model based on decaying ACF and lag 1 spike in PACF */
/*  Estimate model and generate residuls */
/*  Test for significance of AR(1) term  */
/*  Check residuals for White Noise and normality      */
proc arima data = alldata.steel plots(only) = (series (corr) residual (corr normal)) ;
  identify var = export nlag=24 stationarity=(ADF=(0));
  estimate p=(1)   method = ML ;
run ;

/******  STEP 3:  FORECAST *********/
/*  Produce the statistical forecast for the next 3 time periods */
proc arima data = alldata.steel plots(only) =(series (corr) 
                                                       residual (corr normal)
                                                       forecast (forecast forecastonly));
  identify var = export nlag=24 stationarity=(ADF=(0));
  estimate p=() method = ML ;
  forecast lead = 3 out = forecasts;
run ;

/* compute rmse */

data new ;
  set forecasts ;
  resid = export - forecast ;
  resid_sq = resid*resid ;
  resid_mape = abs(resid)/units ;
run ;

proc means data = new ;
  var resid_sq ;
  output sum = SSE out=rmsedat ;
run ;

data rmsecalc ;
  set rmsedat ;
  RMSE = sqrt(SSE/43) ; /* n=44 k=1 */
run ;

proc print data = rmsecalc ;
  var rmse ;
run ;

