#!/bin/bash

if [ "SGE_TASK_ID" == "" ];then
    CONFIG=${1}
    SGE_TASK_ID=1
fi

#CONFIG=${1}
source utils.sh
utils_setup_config ${CONFIG}
utils_SGE_TASK_ID_SUBJ

#if [ ! -d ${SGE_JOB_OUTPUTS}/${subj} ]; then
#    mkdir -p ${SGE_JOB_OUTPUTS}/${subj}; 
#fi


qsub -v CONFIG=${1} -q compute.q -t 1:${nsubj} -o ${SGE_JOB_OUTPUTS} -e ${SGE_JOB_OUTPUTS} dicom_nifti_convert0.sh
