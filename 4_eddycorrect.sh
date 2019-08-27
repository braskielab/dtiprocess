


# PATHING


# DWI=${dir}/${subj}_AXIAL_DTI_mddw_64_SMS4_denoised.nii
# mask=${dir}/${subj}_dwi_brain_mask.nii.gz
# index=${dir}/index.txt
# acqp=${dir}/acqp.txt
# bvec=${dir}/${subj}.bvec
# bval=${dir}/${subj}.bval


# EDDY CORRECT COMMAND ON CORRECTED DWI

# ${eddy_openmp_path} --imain=${DWI} --mask=${mask} --index=${index} --acqp=${acqp} --bvecs=${bvec} --bvals=${bval} --fwhm=0 --flm=quadratic --out=${dir1}/${subj}_eddy_repol --repol --ol_pos --verbose

# OUTPUT

# new bvec file that will be used moving forward

# Create 2 files: index.txt (row of 1s with a 1 for every volume)
# acqp.txt

# ^2 Sufficient to call same index and acqp for each subject



