#!/bin/bash

#$ -S /bin/bash
#$ -o /ifshome/mhapenney/logs -j y

#$ -q compute.q
#-----------------------------------------------------------

CONFIG=${1}

source utils.sh

utils_setup_config ${CONFIG}

#for subj in ${SUBJECT[@]}; do

# Load in subject array

# ----------------------------------------------------------

# STAGE: DENOISING

# ----------------------------------------------------------


cmd="${matlab} -nodesktop -nosplash -r 'addpath('${LPCA_tool}');${matlabCall};exit'"

# Execute
eval ${cmd}

# done
