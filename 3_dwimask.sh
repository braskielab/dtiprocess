

#------------------------------------------------------------------

#SPECIFY WHERE ANTS IS INSTALLED
export ANTSPATH=/usr/local/ANTs-08182015/bin
PATH=/usr/local/ANTs-08182015/bin/:$PATH

#SPECIFY WHERE FSL IS INSTALLED
export FSLDIR="/usr/local/fsl-5.0.11"
    . ${FSLDIR}/etc/fslconf/fsl.sh
FSLDIR=/usr/local/fsl-5.0.11

#SPECIFY WHERE FREESURFER IS INSTALLED
export FREESURFER_HOME="/usr/local/freesurfer-5.3.0_64bit"
export SUBJECTS_DIR=$subject_dir
source $FREESURFER_HOME/SetUpFreeSurfer.sh

#------------------------------------------------------------------

for subj in $@
do

#-----Pathing (Needs Editing)--------------------------------------
#ADPC=/ifs/loni/faculty/mbraskie/ADPC
ADPC=/ifs/loni/faculty/mbraskie/ADPC/dMRI/Scripts/Test
#dmri=${ADPC}/dMRI
#dir=${dmri}/${subj}/baseline
dir=${ADPC}
#dirI=${ADPC}/MPRAGE/${subj}/baseline/${subj}/mri
dirI=${ADPC}
#dirDenoise=${dir}/${subj}_AXIAL_DTI_mddw_64_SMS4_denoised.nii
#dirDenoise=$ADPC/${subj}_AXIAL_DTI_mddw_64_SMS4_denoised.nii
dirDenoise=$ADPC/${subj}_desc-gibs.nii.gz


#dirO=${dir}/Post_Processing/
dirO=$ADPC

#CHANGE ALL ABOVE TO TEST DIRECTORY

if [ ! -d ${dirO} ]
	then
   	mkdir -p ${dirO}
fi
NOTE=${dirO}/${subj}_T1_skullstrip_notes.txt
touch ${NOTE}
#*********************************
cd ${dirI}
# STEP (1) - CONVERT MGZ 2 NII.GZ
	#echo "STAGE: 1 STEP 1 --> ${subj} CONVERT MGZ 2 NII" 
	#cmd="${FREESURFER_HOME}/bin/mri_convert \
	#	--in_type mgz \
	#	--out_type nii \
	#	--out_orientation RAS \
	#	${dirI}/aparc+aseg.mgz ${dirO}/${subj}_aparc+aseg.nii.gz"


	#cmd="${FREESURFER_HOME}/bin/mri_convert \
	#	--in_type mgz \
	#	--out_type nii \
	#	--out_orientation RAS \
	#	${dirI}/orig.mgz ${dirO}/${subj}_orig.nii.gz"



# STEP (2) - BINARY APARC+ASEG
	echo "STAGE: 1 STEP 2 --> ${subj} MAKE BINARY APARC+ASEG"
	cmd="fslmaths ${dir}/${subj}_aparc+aseg.nii.gz -bin ${dirO}/${subj}_aparc+aseg_bin.nii.gz"
	
		eval $cmd 
		echo -e "STAGE: 1 STEP 2 --> ${subj} MAKE BINARY APARC+ASEG \r\n" >> ${NOTE}
		echo -e "COMMAND -> $cmd\r\n" >> ${NOTE}


# STEP (3) - DILATE APARC+ASEG
	echo "STAGE: 1 STEP 3 --> ${subj} DILATE BINARY APARC+ASEG"
	cmd="/usr/local/ANTs/bin/ImageMath 3 ${dirO}/${subj}_aparc+aseg_bin_Dilate.nii.gz MD ${dirO}/${subj}_aparc+aseg_bin.nii.gz 6"
	
		eval $cmd 
		echo -e "STAGE: 1 STEP 3 --> ${subj} DILATE BINARY APARC+ASEG \r\n" >> ${NOTE}
		echo -e "COMMAND -> $cmd\r\n" >> ${NOTE}


# STEP (4) - ERODE APARC+ASEG
	echo "STAGE: 1 STEP 4 --> ${subj} ERODE DILATED BINARY APARC+ASEG"
	cmd="/usr/local/ANTs/bin/ImageMath 3 ${dirO}/${subj}_aparc+aseg_bin_Dilaterode.nii.gz ME ${dirO}/${subj}_aparc+aseg_bin_Dilate.nii.gz 4.5"
	
		eval $cmd 
		echo -e "STAGE: 1 STEP 4 --> ${subj} ERODE DILATED BINARY APARC+ASEG \r\n" >> ${NOTE}
		echo -e "COMMAND -> $cmd\r\n" >> ${NOTE}


# STEP (5) - FILL HOLES OF BRAIN MASK
	echo "STAGE: 1 STEP 5 --> ${subj} FILL HOLES OF BRAIN MASK"
	cmd="fslmaths ${dirO}/${subj}_aparc+aseg_bin_Dilaterode.nii.gz -mul -1 -add 1 ${dirO}/${subj}_aparc+aseg_bin_Dilaterode_invmask.nii.gz"
		
		eval $cmd 
		echo -e "STAGE: 1 STEP 5 --> ${subj} FILL HOLES OF BRAIN MASK: create inversion mask \r\n" >> ${NOTE}
		echo -e "COMMAND -> $cmd\r\n" >> ${NOTE}

	cmd="cluster -i ${dirO}/${subj}_aparc+aseg_bin_Dilaterode_invmask.nii.gz -t 0.5 -o ${dirO}/${subj}_aparc+aseg_bin_Dilaterode_clusters.nii.gz"
		eval $cmd 
		echo -e "STAGE: 1 STEP 5 --> ${subj} FILL HOLES OF BRAIN MASK: create clusters \r\n" >> ${NOTE}
		echo -e "COMMAND -> $cmd\r\n" >> ${NOTE}

	maxind=$(fslstats ${dirO}/${subj}_aparc+aseg_bin_Dilaterode_clusters.nii.gz -R | awk '{ print $2 }');
		echo $maxind
	thresh=$(echo $maxind - 0.5 | bc -l)
		echo -e "STAGE: 1 STEP 5 --> ${subj} FILL HOLES OF BRAIN MASK: identify cluster max \r\n" >> ${NOTE}
		echo -e "COMMAND -> $maxind\r\n" >> ${NOTE}
		echo -e "COMMAND -> $thresh\r\n" >> ${NOTE}

	cmd="fslmaths ${dirO}/${subj}_aparc+aseg_bin_Dilaterode_clusters.nii.gz -thr ${thresh} -bin -mul -1 -add 1 ${dirO}/${subj}_aparc+aseg_bin_Dilaterode_filledmask.nii.gz"
		eval $cmd 
		echo -e "STAGE: 1 STEP 5 --> ${subj} FILL HOLES OF BRAIN MASK: fill holes \r\n" >> ${NOTE}
		echo -e "COMMAND -> $cmd\r\n" >> ${NOTE}


#STEP (6)- REGISTER FS ORIG.nii OUTPUT BRAIN 2 DWI BRAIN
        echo "STAGE: 1 STEP 6 --> ${subj} REGISTER FS 2 DWI SPACE"
	cmd="/usr/local/fsl-5.0.7/bin/flirt \
		-in ${dir}/${subj}_orig.nii.gz \
		-ref ${dirDenoise} \
		-out ${dirO}/${subj}_orig_to_Native.nii.gz \
		-omat ${dirO}/${subj}_orig_to_Native.xfm \
		-dof 12 \
		-datatype float"
		
		eval $cmd 
		echo -e "STAGE: 1 STEP 6 --> ${subj} REGISTER FS 2 DWI SPACE \r\n" >> ${NOTE}
		echo -e "COMMAND -> $cmd\r\n" >> ${NOTE}



#STEP (7)- APPLY TRANSFORMATION TO APARC+ASEG & ERODED BINARY MASK 
#USING NEAREST NEIGHBOUR BECAUSE IT IS A LABEL MAP, NOT! LINEAR 
	echo "STAGE: 1 STEP 7 --> ${subj} APPLY TRANSFORMATION TO APARC+ASEG MASK"	
	cmd="/usr/local/fsl-5.0.7/bin/flirt \
		-interp nearestneighbour \
		-datatype float \
		-in ${dirO}/${subj}_aparc+aseg.nii.gz \
		-ref ${dirDenoise} \
		-applyxfm -init ${dirO}/${subj}_orig_to_Native.xfm \
		-out ${dirO}/${subj}_aparc+aseg_to_Native.nii.gz"

		#-interp nearestneighbour \ 
		
		
		eval $cmd 
		echo -e "STAGE: 1 STEP 7 --> ${subj} APPLY TRANSFORMATION TO APARC+ASEG MASK \r\n" >> ${NOTE}
		echo -e "COMMAND -> $cmd\r\n" >> ${NOTE}


# STEP (8)- APPLY TRANSFORM TO APARC+ASEG BIN DILATE/ERODE
#USING NEAREST NEIGHBOUR BECAUSE IT IS A LABEL MAP, NOT! LINEAR 
	echo "STAGE: 1 STEP 8 --> ${subj} APPLY TRANSFORMATION TO APARC+ASEC BIN DILATE ERODE MASK"
	cmd="/usr/local/fsl-5.0.7/bin/flirt \
		-interp nearestneighbour \
		-datatype float \
		-in ${dirO}/${subj}_aparc+aseg_bin_Dilaterode_filledmask.nii.gz \
		-ref ${dirDenoise} \
		-applyxfm -init ${dirO}/${subj}_orig_to_Native.xfm \
		-out ${dir}/${subj}_dwi_brain_mask.nii.gz"
		
	
		eval $cmd 
		echo -e "STAGE: 1 STEP 8 --> ${subj} APPLY TRANSFORMATION TO APARC+ASEC BIN DILATE ERODE MASK \r\n" >> ${NOTE}
		echo -e "COMMAND -> $cmd\r\n" >> ${NOTE}


# STEP (9) - SKULLSTRIP T1 BRAIN USING ERODE & DILATE MASK
	echo "STAGE: 1 STEP 9 --> ${subj} CREATE SKULLSTRIP BY MULTIPLYING MASK TO DWI BRAIN"
	cmd="fslmaths ${dirDenoise} -mul ${dir}/${subj}_dwi_brain_mask.nii.gz ${dirDenoise}"
	
		eval $cmd 
		echo -e "STAGE: 1 STEP 9 --> ${subj} CREATE SKULLSTRIP BY MULTIPLYING MASK TO DWI BRAIN \r\n" >> ${NOTE}
		echo -e "COMMAND -> $cmd\r\n" >> ${NOTE}

#Multiply Edited Mask by N4 to get normalised Skull strip - name it ${subj}_N4_brain.nii.gz... Not necessary since DWI data is denoised in a previous step - EH

cd ${dir}

chmod -f -R 775 *

done






# INSERT DWI MASKING SCRIPT -> multiply game mask

# OUTPUT

# DWI_BET.nii.gz


