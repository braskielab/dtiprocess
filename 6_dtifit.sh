## DTI FIT -------

CONFIG=${1}

source utils.sh
utils_setup_config ${CONFIG}

bvec=${dir}/${subj}/output/${subj}.bvec
bval=${dir}/${subj}/output/${subj}.bval

${DTIFIT_PATH} -w -k ${dir}/${subj}/output/${subj}_d1corr_nii.gz -o ${dir}/${subj}/output/${subj}_dtifit -m ${dir}/${subj}/output/${subj}_dwi_brain_mask.nii.gz -r ${bvec} -b ${bval} --wls --save_tensor


