#!/bin/bash
#$ -cwd

# load config

CONFIG="dti.config"
source utils.sh

utils_setup_config ${CONFIG}
utils_SGE_TASK_ID_SUBJ

# Testing DICOM to Nifti conversion (DTI) with json info

# Make output directory if does NOT exist

if [ ! -d ${output}/${subj} ]
    then
    mkdir -p ${output}/${subj}
fi

cmd="${DCM2NIIX} -z y -b Y -o ${output}/${subj} ${in}"
eval $cmd

# Rename

cd ${output}/${subj}
mv *nii ${subj}_AXIAL_DTI_mddw_64_SMS4.nii.gz
chmod 775 *
