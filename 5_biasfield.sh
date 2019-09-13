




# BIAS FIELD CORRECTION -------------------

# current problem with script: error in one of the called functions within mrtrix3

export PATH=“/ifs/loni/faculty/mbraskie/tools/mrtrix3/bin:/ifs/loni/faculty/mbraskie/tools/mrtrix3/lib:/ifs/loni/faculty/mbraskie/tools/mrtrix3/share:$PATH”
export LD_LIBRARY_PATH=/ifshome/dmoyer/gcc-5.2.0/lib64:${LD_LIBRARY_PATH}
export PATH=/ifs/loni/faculty/thompson/four_d/igc_basics/anaconda3/bin:$PATH
export ANTSPATH=/usr/local/ANTs_2.2.0/bin/bin/
PATH=${ANTSPATH}:$PATH 

/ifs/loni/faculty/mbraskie/tools/mrtrix3/bin/dwibiascorrect ${dir}/output/${subj}/${subj}_eddy_repol.nii.gz ${dir}/output/${subj}/${subj}_d1corr_nii.gz -ants -mask ${dir}/output/${subj}/${subj}_dwi_brain_mask.nii.gz -bias ${dir}/output/${subj}/${subj}_bias.nii.gz -fslgrad ${bvec} ${bval} -tempdir ${temp_dir}

