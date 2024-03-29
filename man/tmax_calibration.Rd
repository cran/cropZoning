% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calibration_tmax_and_tmin.R
\name{tmax_calibration}
\alias{tmax_calibration}
\title{Calibration of maximum air temperature from TerraClimate}
\usage{
tmax_calibration(slope, intercept, tmax_stack)
}
\arguments{
\item{slope}{the slope of the linear regression (numeric)}

\item{intercept}{the intercept of the linear regression (numeric)}

\item{tmax_stack}{stack of maximum air temperature}
}
\value{
Returns a SpatRaster object of calibrated maximum air temperature.
}
\description{
This function will calibrate the maximum air temperature from TerraClimate dataset based in the relationship with observed weather stations data.The values of slope and intercept informed in example correspond a calibration performed between 'Terraclimate' images and INMET automatic weather stations realized for all the brazilian territory.
}
\examples{
\dontrun{

tmax_cal<- tmax_calibration(slope = 0.874787, intercept = 4.612894 , tmax_stack = tmax);
}
}
