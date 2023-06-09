#!/bin/bash

KEYS_TO_ENCRYPT="$3"
set -eu

FULL_FILEPATH="$1"
PUBLIC_KEY_FILEPATH="$2"
DIRECTORY_PATH=$(dirname "$FULL_FILEPATH")
FILENAME=$(basename -- "$FULL_FILEPATH")
EXTENSION="${FILENAME##*.}"
NAME_PART="${FILENAME%.*}"

if [ -z "$KEYS_TO_ENCRYPT" ]; then
  SOPS_COMMAND=""
else
  SOPS_COMMAND="--encrypted-regex=^(${KEYS_TO_ENCRYPT})$"
fi

echo "FULL_FILEPATH =  ${FULL_FILEPATH}"
echo "FILENAME = ${FILENAME}"
echo "EXTENSION = ${EXTENSION}"
echo "NAME_PART = ${NAME_PART}"
echo "DIRECTORY_PATH = ${DIRECTORY_PATH}"
echo "SOPS_COMMAND = ${SOPS_COMMAND}"

ENCRYPTED_FILE="${DIRECTORY_PATH}/${NAME_PART}.enc.${EXTENSION}"

#sops --encrypt --age $(cat ~/.sops/key.txt |grep -oP "public key: \K(.*)") $SOPS_COMMAND $FULL_FILEPATH > $ENCRYPTED_FILE
sops --encrypt --age $(cat ${PUBLIC_KEY_FILEPATH}) $SOPS_COMMAND $FULL_FILEPATH > $ENCRYPTED_FILE

# rm $FULL_FILEPATH
# mv $ENCRYPTED_FILE $FULL_FILEPATH
# ENCRYPTED_FILE=$FULL_FILEPATH

echo "SOPS encrypted ${FULL_FILEPATH} to ${ENCRYPTED_FILE} successfully."
