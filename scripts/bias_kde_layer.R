.libPaths("/home/davidpw/R/lib/3.6")

library(raster)
library(sf)
library(MASS)
library(bushfireSOS)

points <- rbind(
  read.csv("Occurrence_data/One_species_detection_per_1km_presence_only_AZM_National_Dataset_SDM.csv")[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Macropus agilis",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Ardeotis australis",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Dasycercus blythi",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Camelus dromedarius",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Felis catus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Tiliqua multifasciata",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Bos taurus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Dasycercus cristicauda",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Canis lupus dingo",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Equus asinus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Notomys fuscus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Dromaius novaehollandiae",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Macropus robustus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Vulpes vulpes",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Varanus gouldii",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Egernia kintorei",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Macrotis lagotis",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Equus caballus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Rattus villosissimus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Leipoa ocellata",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Liopholis striata",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  # bushfireSOS::load_pres_bg_data(species = "Notoryctes caurinus",
  #                                email = "david.wilkinson.research@gmail.com",
  #                                save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Onychogalea unguifera",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Varanus giganteus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Oryctolagus cuniculus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Macropus rufus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Tachyglossus aculeatus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Notoryctes typhlops",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Lagorchestes conspicillatus",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Petrogale lateralis",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Tiliqua occipitalis",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")],
  bushfireSOS::load_pres_bg_data(species = "Notomys alexis",
                                 email = "david.wilkinson.research@gmail.com",
                                 save.map = FALSE)$processed.data[, c("Longitude", "Latitude")])

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


road_distance <- raster("../Bushfire_Response/bushfireSOS_workflow/bushfireResponse_data/spatial_layers/aus_road_distance_1000_aa.tif") # this the distance to roads layer that Adam generated. In this layer areas further away from roads have higher values (higher distance). 

# standradize 0 to 1
road_distance_invert_std <- spatialEco::raster.transformation(road_distance_invert, trans = "norm", smin = 0, smax = 1)

kde_h1e7_roads <- kde_h1e7.ras_std+road_distance_invert_std

kde_h1e7_roads_std <- spatialEco::raster.transformation(kde_h1e7_roads, trans = "norm", smin = 0, smax = 1)

writeRaster(kde_h1e7_roads_std,
            "Covariate_stacks/kde_h1e7_roads_ALA.tif",
            overwrite = TRUE)