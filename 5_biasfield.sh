




# BIAS FIELD CORRECTION -------------------

# current problem with script: error in one of the called functions within mrtrix3

export PATH=“$HOME/software/mrtrix3/bin:/$HOME/software/mrtrix3/lib:/$HOME/software/mrtrix3/share:$PATH”
export LD_LIBRARY_PATH=/ifshome/dmoyer/gcc-5.2.0/lib64:${LD_LIBRARY_PATH}
export PATH=/ifs/loni/faculty/thompson/four_d/igc_basics/anaconda3/bin:$PATH
export ANTSPATH=/usr/local/ANTs_2.2.0/bin/bin/
PATH=${ANTSPATH}:$PATH 

/ifshome/ehaddad/software/mrtrix3/bin/dwibiascorrect ${Input} ${Output}_d1corr_nii.gz -ants -mask ${mask} -bias ${output}_bias.nii.gz -fslgrad ${bvec} ${bval} -tempdir ${temp_dir}

