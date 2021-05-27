### I'll start by changing the bandwidth.

# .libPaths()
# [1] "C:/Users/DBRIZUELA/Documents/R/win-library/3.6" "C:/Program Files/R/R-3.6.0/library"

library(mapview)
library(spatialEco)
library(MASS)
library(raster)

### Original script. 

# coords <- st_coordinates(points.sf)
# 
# kde <- MASS::kde2d(coords[ , 1], 
#                    coords[ , 2], 
#                    # n = c(ncol(points.ras), nrow(points.ras)),
#                    n = c(ncol(ras), nrow(ras)))
# 
# kde.ras <- raster(kde)
# kde.ras <- setExtent(kde.ras,
#                      ras)
# crs(kde.ras) <- "+proj=aea +lat_0=0 +lon_0=132 +lat_1=-18 +lat_2=-36 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
# # plot(kde.ras)
# 
# # kde_reproj <- projectRaster(kde.ras,
# #                             crs = "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +units=m +no_defs")
# 
# mask <- raster("Covariate_stacks/aridzone.tif")
# 
# kde.ras <- crop(kde.ras,
#                 mask)
# 
# kde.mask <- mask(kde.ras,
#                  mask)
# 
# kde.mask[kde.mask < 0] <- .Machine$double.eps

# plot(kde.mask)



# 
# # h = 1e3 --------------------------------------------------------------
# kde_h1e3 <- MASS::kde2d(coords[ , 1], 
#                    coords[ , 2],
#                    n = c(ncol(ras), nrow(ras)),
#                    h =  rep(1000, 1000))
# 
# kde_h1e3.ras <- raster(kde_h1e3)
# kde_h1e3.ras <- setExtent(kde_h1e3.ras,
#                      ras)
# crs(kde_h1e3.ras) <- "+proj=aea +lat_0=0 +lon_0=132 +lat_1=-18 +lat_2=-36 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
# 
# kde_h1e3.ras_std <- spatialEco::raster.transformation(kde_h1e3.ras, trans = "norm", smin = 0, smax = 1)
# 
# kde_h1e3.ras <- crop(kde_h1e3.ras,
#                    mask)
# 
# kde_h1e3.ras.mask <- mask(kde_h1e3.ras,
#                         mask)
# 
# kde_h1e3.ras.mask[kde_h1e3.ras.mask < 0] <- .Machine$double.eps
# 
# 
# 
# 
# 
# # h = 1e4 --------------------------------------------------------------
# kde_h1e4 <- MASS::kde2d(coords[ , 1], 
#                        coords[ , 2],
#                        n = c(ncol(ras), nrow(ras)),
#                        h = rep(10000, 10000))
# 
# kde_h1e4.ras <- raster(kde_h1e4)
# kde_h1e4.ras <- setExtent(kde_h1e4.ras,
#                      ras)
# crs(kde_h1e4.ras) <- "+proj=aea +lat_0=0 +lon_0=132 +lat_1=-18 +lat_2=-36 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
# 
# kde_h1e4.ras <- crop(kde_h1e4.ras,
#                    mask)
# 
# kde_h1e4.ras.mask <- mask(kde_h1e4.ras,
#                         mask)
# 
# kde_h1e4.ras.mask[kde_h1e4.ras.mask < 0] <- .Machine$double.eps
# 



# h = 1e5 --------------------------------------------------------------
kde_h1e5 <- MASS::kde2d(coords[ , 1], 
                      coords[ , 2],
                      n = c(ncol(ras), nrow(ras)),
                      h = rep(100000, 100000))

kde_h1e5.ras <- raster(kde_h1e5)
kde_h1e5.ras <- setExtent(kde_h1e5.ras,
                     ras)
crs(kde_h1e5.ras) <- "+proj=aea +lat_0=0 +lon_0=132 +lat_1=-18 +lat_2=-36 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

kde_h1e5.ras <- crop(kde_h1e5.ras,
                mask)

kde_h1e5.ras.mask <- mask(kde_h1e5.ras,
                 mask)

kde_h1e5.ras.mask[kde_h1e5.ras.mask < 0] <- .Machine$double.eps

kde_h1e5.ras_std <- spatialEco::raster.transformation(kde_h1e5.ras.mask, trans = "norm", smin = 0, smax = 1)

writeRaster(kde_h1e5.ras_std,
            "Covariate_stacks/kde.h1e5.tif",
            overwrite = TRUE)





# h = 1e6 --------------------------------------------------------------
kde_h1e6 <- MASS::kde2d(coords[ , 1], 
                      coords[ , 2],
                      n = c(ncol(ras), nrow(ras)),
                      h = rep(1000000, 1000000)) # 1 million

kde_h1e6.ras <- raster(kde_h1e6)
kde_h1e6.ras <- setExtent(kde_h1e6.ras,
                        ras)
crs(kde_h1e6.ras) <- "+proj=aea +lat_0=0 +lon_0=132 +lat_1=-18 +lat_2=-36 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

kde_h1e6.ras <- crop(kde_h1e6.ras,
                   mask)

kde_h1e6.ras.mask <- mask(kde_h1e6.ras,
                        mask)

kde_h1e6.ras.mask[kde_h1e6.ras.mask < 0] <- .Machine$double.eps

kde_h1e6.ras_std <- spatialEco::raster.transformation(kde_h1e6.ras.mask, trans = "norm", smin = 0, smax = 1)

writeRaster(kde_h1e6.ras_std,
            "Covariate_stacks/kde.h1e6.tif",
            overwrite = TRUE)



# h = 1e7 --------------------------------------------------------------
kde_h1e7 <- MASS::kde2d(coords[ , 1], 
                        coords[ , 2],
                        n = c(ncol(ras), nrow(ras)),
                        h = rep(10000000, 10000000)) # 10 million

kde_h1e7.ras <- raster(kde_h1e7)
kde_h1e7.ras <- setExtent(kde_h1e7.ras,
                          ras)
crs(kde_h1e7.ras) <- "+proj=aea +lat_0=0 +lon_0=132 +lat_1=-18 +lat_2=-36 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

kde_h1e7.ras <- crop(kde_h1e7.ras,
                     mask)

kde_h1e7.ras.mask <- mask(kde_h1e7.ras,
                          mask)

kde_h1e7.ras.mask[kde_h1e7.ras.mask < 0] <- .Machine$double.eps

kde_h1e7.ras_std <- spatialEco::raster.transformation(kde_h1e7.ras.mask, trans = "norm", smin = 0, smax = 1)

writeRaster(kde_h1e7.ras_std,
            "Covariate_stacks/kde.h1e7.tif",
            overwrite = TRUE)




# h = 5e5 --------------------------------------------------------------

kde_h5e5 <- MASS::kde2d(coords[ , 1], 
                      coords[ , 2],
                      n = c(ncol(ras), nrow(ras)),
                      h = rep(500000, 500000)) # half a million

kde_h5e5.ras <- raster(kde_h5e5)
kde_h5e5.ras <- setExtent(kde_h5e5.ras,
                        ras)
crs(kde_h5e5.ras) <- "+proj=aea +lat_0=0 +lon_0=132 +lat_1=-18 +lat_2=-36 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

kde_h5e5.ras <- crop(kde_h5e5.ras,
                   mask)

kde_h5e5.ras.mask <- mask(kde_h5e5.ras,
                        mask)

kde_h5e5.ras.mask[kde_h5e5.ras.mask < 0] <- .Machine$double.eps

kde_h5e5.ras_std <- spatialEco::raster.transformation(kde_h5e5.ras.mask, trans = "norm", smin = 0, smax = 1)

writeRaster(kde_h5e5.ras_std,
            "Covariate_stacks/kde.h5e5.tif",
            overwrite = TRUE)




# Incorporate distance to roads layer -----------------------------------------------------------

road_distance <- raster("C:/Users/DBRIZUELA/Dropbox/Bushfire_Response/bushfireSOS_workflow/bushfireResponse_data/spatial_layers/aus_road_distance_1000_aa.tif") # this the distance to roads layer that Adam generated. In this layer areas further away from roads have higher values (higher distance). 
# However, for the purpose of a bias layer, the values should be inverted, given that we want higher density of background points for PB modelling at areas more intensely sampled (closer to roads).

# invert values:
road_distance_invert <- spatialEco::raster.invert(road_distance)
# save raster
writeRaster(road_distance_invert,
            "C:/Users/DBRIZUELA/Dropbox/Bushfire_Response/bushfireSOS_workflow/bushfireResponse_data/spatial_layers/aus_road_distance_1000_aa_inverted.tif")

# standradize 0 to 1
road_distance_invert_std <- spatialEco::raster.transformation(road_distance_invert, trans = "norm", smin = 0, smax = 1)


### Now I'll add up the bias layers based only on density records with the inverted distance to roads.
## I'll do this only for bias layers  kde_h1e5, kde_h5e5, kde_h1e6


kde_h1e5_roads <- kde_h1e5.ras_std+road_distance_invert_std
kde_h5e5_roads <- kde_h5e5.ras_std+road_distance_invert_std
kde_h1e6_roads <- kde_h1e6.ras_std+road_distance_invert_std
kde_h1e7_roads <- kde_h1e7.ras_std+road_distance_invert_std

kde_h1e5_roads_std <- spatialEco::raster.transformation(kde_h1e5_roads, trans = "norm", smin = 0, smax = 1)

kde_h5e5_roads_std <- spatialEco::raster.transformation(kde_h5e5_roads, trans = "norm", smin = 0, smax = 1)

kde_h1e6_roads_std <- spatialEco::raster.transformation(kde_h1e6_roads, trans = "norm", smin = 0, smax = 1)

kde_h1e7_roads_std <- spatialEco::raster.transformation(kde_h1e7_roads, trans = "norm", smin = 0, smax = 1)

writeRaster(kde_h1e5_roads_std,
            "Covariate_stacks/kde_h1e5_roads.tif",
            overwrite = TRUE)

writeRaster(kde_h5e5_roads_std,
            "Covariate_stacks/kde_h5e5_roads.tif",
            overwrite = TRUE)

writeRaster(kde_h1e6_roads_std,
            "Covariate_stacks/kde_h1e6_roads.tif",
            overwrite = TRUE)

writeRaster(kde_h1e7_roads_std,
            "Covariate_stacks/kde_h1e7_roads.tif",
            overwrite = TRUE)



par(mfrow=c(1,2))
plot(kde_h1e6_roads_std, main="kde_h1e6_roads")
plot(kde_h1e7_roads_std, main="kde_h1e7_roads")