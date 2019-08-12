#!/bin/bash
#$ -cwd

# load config

CONFIG="dti.config"

source utils.sh

utils_setup_config ${CONFIG}

# Testing DICOM to Nifti conversion (DTI) with json info

#for subj in $@; do
utils_setup_config ${CONFIG}

in="/ifshome/mhapenney/dtitest/ADPC/509950/AXIAL_DTI_mddw_64_SMS4/*.0*/S*"

# Make output directory if does NOT exist

if [ ! -d ${output} ]
    then
    mkdir -p ${output}
fi

${DCM2NIIX} -b Y -o /ifshome/mhapenney/dtitest/ADPC/output ${in}

# Rename

cd ${output}
mv *nii ${subj}_AXIAL_DTI_mddw_64_SMS4.nii
chmod 775 *
