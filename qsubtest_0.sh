#!/bin/bash



CONFIG="dti.config"
source utils.sh
utils_setup_config ${CONFIG}
utils_SGE_TASK_ID_SUBJ ${CONFIG}


cd /ifshome/mhapenney
mkdir ${subj}
