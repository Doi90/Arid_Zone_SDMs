.libPaths("/home/davidpw/R/lib/3.6")

library(raster)
library(sf)
library(MASS)


points <- read.csv("Occurrence_data/One_species_detection_per_1km_presence_only_AZM_National_Dataset_SDM.csv")

points.sf <- sf::st_as_sf(points,
                          coords = c("Longitude", "Latitude"),
                          crs = 4326)

points.sf <- st_transform(points.sf,
                          crs = "+proj=aea +lat_0=0 +lon_0=132 +lat_1=-18 +lat_2=-36 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
# mapview(points.sf)

ras <- raster("Covariate_stacks/AZM_covariate_stack_clipped_uncorrelated.tif")

# points.ras <- rasterize(points.sf, ras, 1)
# mapview(points.ras, maxpixels = 10000000)

coords <- st_coordinates(points.sf)

kde <- MASS::kde2d(coords[ , 1], 
                   coords[ , 2], 
                   # n = c(ncol(points.ras), nrow(points.ras)),
                   n = c(ncol(ras), nrow(ras)))

kde.ras <- raster(kde)
kde.ras <- setExtent(kde.ras,
                     ras)
crs(kde.ras) <- "+proj=aea +lat_0=0 +lon_0=132 +lat_1=-18 +lat_2=-36 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
# plot(kde.ras)

# kde_reproj <- projectRaster(kde.ras,
#                             crs = "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +units=m +no_defs")

mask <- raster("Covariate_stacks/aridzone.tif")

kde.ras <- crop(kde.ras,
                mask)

kde.mask <- mask(kde.ras,
                 mask)

kde.mask[kde.mask < 0] <- .Machine$double.eps

# plot(kde.mask)

writeRaster(kde.mask,
            "Covariate_stacks/kde_bias_layer.tif",
            overwrite = TRUE)
