#!/bin/bash

# file gen_signature.sh

# fail fast
set -e

SHORT_BOARD_NAME=${1:-$SHORT_BOARD_NAME}

cd $(dirname "$0")

SIGNATURE_FILE_NAME=tunerstudio/generated/signature_${SHORT_BOARD_NAME}.txt
echo "Generating signature for ${SHORT_BOARD_NAME}"

TEMP_FILE="${SIGNATURE_FILE_NAME}.temp"

# generate a unique signature
date=`TZ=Europe/London date +"%Y.%m.%d"`
echo "! Generated by gen_signature.sh" > ${TEMP_FILE}

echo "! SIGNATURE_HASH is a built-in variable generated by config_definition-all.jar" >> ${TEMP_FILE}

# read the current git branch name
branchname=`git branch --show-current`
if [ "${branchname}" = "" ]; then
 # custom board, empty value while executed within submodule
 branchname=${GITHUB_REF_NAME}
 echo "! Using env variable branch $branchname" >> ${TEMP_FILE}
else
 echo "! Current branch is: $branchname" >> ${TEMP_FILE}
fi

WHITELABEL=rusEFI

echo "#define TS_SIGNATURE \"${WHITELABEL} $branchname.$date.${SHORT_BOARD_NAME}.@@SIGNATURE_HASH@@\"" >> ${TEMP_FILE}

# We will generate the signature in a temp file, then only use it if it has changed.
# This is to avoid updating the timestamp of the signature file, which would cause the configs to regenerate when they don't need to.
# cmp compares files to see if they are different. If they are different or if SIGNATURE_FILE_NAME doesn't exist, the mv command will run.
# We redirect errors to /dev/null to supress the error if SIGNATURE_FILE_NAME doesn't exist
cmp ${TEMP_FILE} ${SIGNATURE_FILE_NAME} 2>/dev/null || mv -f ${TEMP_FILE} ${SIGNATURE_FILE_NAME}
rm -f ${TEMP_FILE}

exit 0
