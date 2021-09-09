#!/bin/bash
#
# Set required nodes.
#SBATCH --nodes=1
#
# Set up nodes for job. 
#SBATCH --ntasks=1
#
# Set partition
#SBATCH -p "physical,snowy"
#
# Set number of CPUs
#SBATCH --cpus-per-task=1
#
# Set memory limit
#SBATCH --mem=60000
#
# Set wall time
#SBATCH --time=1-00
#
# Set job name
#SBATCH --job-name="Western.bluetongue"
#    
# Set output file
#SBATCH --output="/data/gpfs/projects/punim0200/Arid_zone_SDMs/outputs/slurm/Western.bluetongue.out"
#
# Set email notifications
#SBATCH --mail-user=david.wilkinson.research@gmail.com
#SBATCH --mail-type=ALL,TIME_LIMIT_50,TIME_LIMIT_80,TIME_LIMIT_90

module purge

module load proj/6.2.1
module load gcc/8.3.0  
module load openmpi/3.1.4
module load gdal/3.0.2-python-3.7.4
module load rgdal/1.4-4-r-3.6.0
module load geos/3.7.2-python-3.7.4
module load netcdf/4.7.1
module load nodejs
module load openssl
module load r/3.6.0

export http_proxy=http://wwwproxy.unimelb.edu.au:8000
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy

cd /data/gpfs/projects/punim0200/Arid_zone_SDMs

Rscript --vanilla scripts/workflows/workflow_Western.bluetongue.R 