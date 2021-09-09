#############################################
#############################################
###                                       ###
###       TEMPLATE FOR SDM WORKFLOW       ###
###                                       ###
###   This script file is a template for  ###
### the species distribution modelling    ###
### workflow as part of the arid zone     ###
### modelling project.                    ###
###                                       ###
###   For each actual species workflow we ###
### should copy this template into a new  ###
### file. Then edit the workflow to suit  ###
### the species being analysed.           ###
###                                       ###
###   Species-specific workflow files are ###
### to be saved as:                       ###
###                                       ###
###   "species_name_workflow.R"           ###
###                                       ###
###   Species-specific workflow files are ###
### to be saved in the appropriate        ###
### folder:                               ###
###                                       ###
###   "scripts/workflows"                 ###
###                                       ###
#############################################
#############################################

########################
### WORKFLOW DETAILS ###
########################

## Species:
## Analyst:
## Reviewer:
## SDM Required: Y/N
## Built SDM: Y/N
## Data available: PO/PA
## Type of SDM: PresBG/PresAbs/Hybrid
## Number of presence records:
## Number of background points:
## Type of background points:
## Date completed:
## Any other comments:

species <- "Agile_wallaby"

species_col <- "common.name"

#####################
### Load Packages ###
#####################

.libPaths("/home/davidpw/R/lib/3.6")

library(bushfireSOS)

#########################
### Load Species Data ###
#########################

## Presence background data

spp_data <- bushfireSOS::load_pres_bg_data_arid(filepath = "Occurrence_data/One_species_detection_per_1km_presence_only_AZM_National_Dataset_SDM.csv",
                                                species = species,
                                                species_col = species_col)

spp_data1 <- bushfireSOS::load_pres_bg_data(species = "Macropus agilis",
                                            email = "david.wilkinson.research@gmail.com",
                                            save.map = FALSE)

spp_data1$data$species <- species

spp_data$data <- rbind(spp_data$data,
                       spp_data1$data)

bushfireSOS::map_sp_data(spp_data, 
                         crs = 4326)

nrow(spp_data$data)

saveRDS(spp_data,
        sprintf("outputs/spp_data_tmp/spp_data_%s.rds",
                gsub(" ", "_", species)))

# spp_data <- readRDS(sprintf("bushfireResponse_data/outputs_1990/spp_data_tmp/spp_data_%s.rds",
#                             gsub(" ", "_", species)))

###############################
### Load Environmental Data ###
###############################

# Load appropriate environmental raster data

env_data <- bushfireSOS::load_arid_env_data(file = "Covariate_stacks/AZM_covariate_stack_clipped_uncorrelated_plus_fire_freq.tif")

#########################
### Background Points ###
#########################

# Generate our background points

bias_layer <- raster::raster("Covariate_stacks/kde_h1e7_roads_ALA.tif")

spp_data <- bushfireSOS::background_points_arid(species = species,
                                                spp_data = spp_data,
                                                bias_layer = bias_layer,
                                                n_samples = 10000)

## Check that there are >= 20 presences (1s) and an appropriate number of
## background points (1000 * number of states with data for target group,
## or 10,000 for random)

table(spp_data$data$Value)

#######################
### Data Extraction ###
#######################

spp_data <- bushfireSOS::env_data_extraction(spp_data = spp_data,
                                             env_data = env_data)

# bushfireSOS::map_sp_data(spp_data,
#                          only_presences = TRUE)

saveRDS(spp_data,
        sprintf("outputs/spp_data/spp_data_%s.rds",
                gsub(" ", "_", species)))

#####################
### SDM Required? ###
#####################

# Do we have >=20 presence records?
# Y/N

# Can we fit an SDM for this species?
# Y/N 

# If no, how should we create an output for Zonation?

#########################
### Use Existing SDM? ###
#########################

# Can we use an existing SDM for this species?
# Y/N

# If yes, how should we ensure its suitable for our purposes?

if(nrow(spp_data$data[spp_data$data$Value == 1, ]) >= 20){
  
  print("At least 20 presence records")
  
  # feature_options <- c("default",
  #                      "lqp",
  #                      "lq",
  #                      "l")
  # 
  ########################
  ### Model Evaluation ###
  ########################
  
  # Perform appropriate model checking
  # Ensure features is set identical to that of the above full model
  # If Boyce Index returns NAs then re-run the cross-validation with
  #  one fewer fold i.e. 5 > 4 > 3 > 2 > 1
  
  # for(feat in feature_options){
  #   
  #   features <- feat
  #   
  model_eval <- tryCatch(expr = bushfireSOS::cross_validate(spp_data = spp_data,
                                                            type = "po",
                                                            k = 5,
                                                            # parallel = FALSE,
                                                            filepath = sprintf("outputs/model/MaxEnt_outputs_CV/%s",
                                                                               gsub(" ", "_", species))),
                         err = function(err){ return(NULL) })
  
  #   if(!is.null(model_eval)){
  #     break()
  #   }
  #   
  # }
  
  if(!is.null(model_eval)){
    
    print("Model evaluation complete, fitting full model")
    
    saveRDS(model_eval,
            sprintf("outputs/model_eval/model_eval_%s.rds",
                    gsub(" ", "_", species)))
    
    #####################
    ### Model Fitting ###
    #####################
    
    # Fit an appropriate model type
    
    # Comment out unused methods instead of deleting them in case more
    # data becomes available at a later date
    
    ## Presence only
    ## Features should equal "default" on first attempt. Can reduce 
    ## to "lqp", "lq", or "l" if model is too complex to fit 
    
    model <- bushfireSOS::fit_pres_bg_model(spp_data = spp_data,
                                            tuneParam = TRUE,
                                            k = 5,
                                            filepath = sprintf("outputs/model/MaxEnt_outputs/%s",
                                                               gsub(" ", "_", species)))
    
    saveRDS(model,
            sprintf("outputs/model/model_%s.rds",
                    gsub(" ", "_", species)))
    
    ## Presence absence model
    
    # model <- bushfireSOS::fit_pres_abs_model()
    
    ## Hybrid model
    
    # model <- bushfireSOS::fit_hybrid_model()
    
    ########################
    ### Model Prediction ###
    ########################
    
    # Perform appropriate prediction
    
    prediction <- bushfireSOS::model_prediction(model = model,
                                                env_data = env_data,
                                                mask = "Covariate_stacks/aridzone.tif",
                                                parallel = FALSE)
    
    raster::writeRaster(prediction,
                        sprintf("outputs/predictions/predictions_%s.tif",
                                gsub(" ", "_", species)),
                        overwrite = TRUE)
    
    prediction_threshold <- bushfireSOS::predict_threshold(pred_ras = prediction,
                                                           threshold = model_eval[3])
    
    raster::writeRaster(prediction_threshold,
                        sprintf("outputs/predictions/predictions_%s_threshold.tif",
                                gsub(" ", "_", species)),
                        overwrite = TRUE)
    
    # mapview::mapview(prediction)
    
  } else{
    
    print("Model evaluation failed")
    
  } 
  
} else {
  
  print("Less than 20 records, no model fit")
  
}

#################
### Meta Data ###
#################

# Store meta data relevant to analysis

meta_data <- sessionInfo()

saveRDS(meta_data,
        sprintf("outputs/meta_data/meta_data_%s.rds",
                gsub(" ", "_", species)))
