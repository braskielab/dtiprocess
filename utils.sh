
utils_setup_config() {
     if  [ -e ${1} ]; then
       source ${1}
     else
       echo "Configuration file ${1} not found. :( Aborting"
       exit 1
     fi
	
	readarray SUBJECT < ${subjectlist}
}

utils_SGE_TASK_ID_SUBJ(){

    #if [ "$SGE_TASK_ID" == "" ]; then
	#echo "SGE_TASK_ID not set. Aborting."
	#exit 1
    #fi
    
    if [ ! -d ${SGE_JOB_OUTPUTS}/${subj} ];then
        mkdir -p ${SGE_JOB_OUTPUTS}/${subj};
    fi

    #source ${1} 
    x=(${SUBJECT[@]})
    subj=${x[$SGE_TASK_ID-1]}    
    nsubj=${#SUBJECT[@]}
 
}
