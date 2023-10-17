#!/bin/bash

echo '========================================='
echo '========= RUN INTEGRATION TESTS ========='
echo '========================================='

ENV_STATE=$1
BEHAVE_TAGS=$2
CONT_FOLDER=$3
CONT_FOLDER_REPORTS=$4

echo "Environment selected: ${ENV_STATE}"
echo "Execute behave integration tests for tags: ${BEHAVE_TAGS}"


echo "Display behave version: " &&\
    python3 -m behave --version  

#
# Execute behave (Behavior-Driven-Development/Testing)
#

if  [ "${BEHAVE_TAGS}" = "runall" ];   then \
   if  [ "${ENV_STATE}" = "stage" ];   then  \
       python3 -m behave /${CONT_FOLDER}/applications/features --verbose --junit --junit-directory /${CONT_FOLDER_REPORTS} --no-logcapture --summary --tags ~@only_dev; \
   else \
       python3 -m behave /${CONT_FOLDER}/applications/features --verbose --junit --junit-directory /${CONT_FOLDER_REPORTS} --no-logcapture --summary; \
   fi; \
else \
   python3 -m behave /${CONT_FOLDER}/applications/features --verbose --junit --junit-directory /${CONT_FOLDER_REPORTS} --no-logcapture --summary --tags ${BEHAVE_TAGS}; \
fi


#
# Check if the python3 command exited with code 1. 
# If so, propagete the exit code to the command run container ... in order to fail the task and therefore, the entire pipeline.
#
if [ "$?" -eq 1 ]; then \
   echo 'BEHAVE TESTS FAILED'; \
   exit 1 ; \ 
fi


echo "FINISHED TEST RUNNUNG"