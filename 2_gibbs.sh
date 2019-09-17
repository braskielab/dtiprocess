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

${GIBBSPATH} ${dir}/${subj}/output/${subj}_denoised.nii.gz ${dir}/${subj}/output/${subj}_desc-gibbs.nii.gz

# Evan Test------------------

#-----Subject Identifier-----

# for subj in $@
# do

#-----Set Pathing-----

# ADPC=/ifs/loni/faculty/mbraskie/ADPC/dMRI/Scripts/Test

#-----Run mredegibbs-----

# /ifs/loni/faculty/shi/spectrum/daydogan/dev/mrtrix3-master_20180723/bin/mrdegibbs ${ADPC}/${subj}_AXIAL_DTI_mddw_64_SMS4_denoised.nii ${subj}_desc-gibbs.nii.gz

