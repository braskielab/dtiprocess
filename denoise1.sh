#!/bin/bash
#$ -cwd

#$ -q compute.q
#-----------------------------------------------------------
# CONFIG & UTILS

CONFIG="dti.config"
source utils.sh

utils_setup_config ${CONFIG}
utils_SGE_TASK_ID_SUBJ

# ----------------------------------------------------------

# STAGE: DENOISING

# ----------------------------------------------------------


cmd="${matlab} -nodesktop -nosplash -r 'addpath('${LPCA_tool}');${matlabCall};exit'"

# Execute
eval ${cmd}

# done

chmod 775 *
