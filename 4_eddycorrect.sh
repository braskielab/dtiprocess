


CONFIG="dti.config"

# PATHING


input=${dir}/${subj}/output/${subj}_desc-gibbs.nii.gz
mask=${dir}/${subj}_dwi_brain_mask.nii.gz
index=${dir}/index.txt
acqp=${dir}/acqp.txt
bvec=${dir}/${subj}.bvec
bval=${dir}/${subj}.bval


# EDDY CORRECT COMMAND ON CORRECTED DWI

${EDDY_COR} --imain=${input} --mask=${mask} --index=${index} --acqp=${acqp} --bvecs=${bvec} --bvals=${bval} --fwhm=0 --flm=quadratic --out=${dir}/${subj}/output/${subj}_eddy_repol --repol --ol_pos --verbose

# OUTPUT

# new bvec file that will be used moving forward

# Create 2 files: index.txt (row of 1s with a 1 for every volume)
# acqp.txt

# ^2 Sufficient to call same index and acqp for each subject


# Evan Test------------------------

#-----Subject Identifier-----

#for subj in $@
#do

#-----Set Pathing-----

#ADPC=/ifs/loni/faculty/mbraskie/ADPC/dMRI/Scripts/Test/Eddy
#dir=${ADPC}
#dirI=${ADPC}
#DWI=/ifs/loni/faculty/mbraskie/ADPC/dMRI/Scripts/Test/${subj}_desc-gibs.nii.gz

#dirO=$ADPC
#dir1=${ADPC}

#mask=/ifs/loni/faculty/mbraskie/ADPC/dMRI/Scripts/Test/${subj}_dwi_brain_mask.nii.gz
#index=/ifs/loni/faculty/mbraskie/ADPC/dMRI/Scripts/Test/index.txt
#acqp=/ifs/loni/faculty/mbraskie/ADPC/dMRI/Scripts/Test/${subj}_acqp.txt
#bvecs=/ifs/loni/faculty/mbraskie/ADPC/dMRI/Scripts/Test/${subj}.bvec
#bval=/ifs/loni/faculty/mbraskie/ADPC/dMRI/Scripts/Test/${subj}.bval

#-----Run eddy_openmp-----

#cmd="/usr/local/fsl-5.0.11/bin/eddy_openmp --imain=${DWI} --mask=${mask} --index=${index} --acqp=${acqp} --bvecs=${bvecs} --bvals=${bval} --fwhm=0 --flm=quadratic --out=${ADPC}/${subj}_eddy_repol --repol --ol_pos --verbose"

#eval $cmd


