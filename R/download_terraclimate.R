#' Download of maximum and minimum air temperature from 'TerraClimate'
#' \if{html}{\figure{logo_cropZoning.png}{options: height= 300 width=auto style = float:right alt= Our logo}}
#'
#' @description This function will download the tmax and tmin images and will load a rasterstack according to the the region of interest (Region and sub_region). The images downloaded by this function are intended to be used for calculating the climatic zoning of crops. To calculate the climatic zoning of the crops, you first have to calculate the mean air temperature (function tmean) and the monthly air temperature (function tmean_monthly). 
#' @param variable Variable to download. The variables can be the minimum (tmin) or maximum (tmax) air temperature of 'TerraClimate' (Rasterstack).
#' @param region Use the "brazil" shapefile to extract the Rasterstack (variable) for one state (Brazilian state), or use the "biomes_brazil" to extract the Rasterstack (variable) for one biome of Brazil.
#' @param sub_region You have two options in this section, if you choice the brazil (in region parameter) you need to choice the Brazilian states, but if you choice the biomes_brazil (in region parameter) you must choice one of Brazilian biomes.
#' @param years The period in years that the function should download. 
#' @import raster
#' @import rgdal
#' @import ncdf4
#' @examples
#' \dontrun{
#' 
#' ### Downloading the minimum air temperature and maximum air temperature based on Brazil states.
#' see_brazil_states()
#' 
#' img <-download_terraclimate(variable = "tmin",
#'                           years = c(2018:2019),
#'                           region = "brazil",
#'                           sub_region = 13)
#' 
#' ### Downloading the minimum air temperature and maximum air temperature based on Brazil states.
#' see_brazil_biomes()
#' 
#' img <-download_terraclimate(variable = "tmin",
#'                           years = c(2018:2019),
#'                           region = "biomes_brazil",
#'                           sub_region = 6)
#' }
#' @return Returns a Rasterstack of tmin (minimum air temperature) or tmax (maximum air temperature).
#' @references
#' The images used in this package can be found in the paper: Abatzoglou, J.T., S.Z. Dobrowski, S.A. Parks, K.C. Hegewisch, 2018, Terraclimate, a high-resolution global dataset of monthly climate and climatic water balance from 1958-2015, Scientific Data.
#' @export

download_terraclimate <- function(variable, years, region, sub_region){
  tempdir<- tempdir()
  outdir<- gsub('\\', '/', tempdir, fixed=TRUE)
  if(variable == "tmax"| variable == "tmin"){
    for(i in 1:length(years)){
      
      baseurl <- paste0("http://thredds.northwestknowledge.net:8080/thredds/fileServer/TERRACLIMATE_ALL/data/TerraClimate_", variable, "_", years[i],".nc")
      name_img<- paste0("TerraClimate_", variable, "_", years[i], ".nc")
      outfile<-paste0(outdir, "/", name_img)
      utils::download.file(url = baseurl, destfile = outfile, mode = "wb")
    }
    setwd(outdir)
    s<-stack(list.files(outdir, pattern = ".nc", full.names = T))
    
    shp<-readOGR(system.file('extdata', paste0(region, ".shp"), package= 'cropZoning'))
    area<-shp[sub_region,]
    s<-crop(s, area)
    s<-mask(s, area)
    
    unlink(paste0(normalizePath(tempdir), "/", dir(tempdir)), recursive = TRUE)
    return(s)
  } else {message("Please, pay attention. You should download the variable tmax or tmin!")}
}


