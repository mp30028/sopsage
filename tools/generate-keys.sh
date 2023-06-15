#!/bin/bash

set -eu

PRIVATE_KEY_OUTPUT_DIR="$1"
PUBLIC_KEY_OUTPUT_DIR="$2"
PRIVATE_KEY_FILENAME="age-key.private"
PUBLIC_KEY_FILENAME="age-key.public"
PRIVATE_KEY_FULL_FILEPATH=$(realpath "${PRIVATE_KEY_OUTPUT_DIR}/${PRIVATE_KEY_FILENAME}")
PUBLIC_KEY_FULL_FILEPATH=$(realpath "${PUBLIC_KEY_OUTPUT_DIR}/${PUBLIC_KEY_FILENAME}")
docker exec -i sopsage /bin/bash -c "age-keygen" > "${PRIVATE_KEY_FULL_FILEPATH}"
cat "${PRIVATE_KEY_FULL_FILEPATH}" | grep -oP "public key: \K(.*)" > "${PUBLIC_KEY_FULL_FILEPATH}"

# remove any existing entries .bashrc
sed -n -i '/^export SOPS_AGE_KEY_FILE=/!p' ~/.bashrc 

# add new entry in .bashrc
echo "export SOPS_AGE_KEY_FILE=${PRIVATE_KEY_FULL_FILEPATH}" >> ~/.bashrc

echo "update profile changes: run 'source ~/.profile'"
echo "check environment variable has been set correctly: run 'echo \$SOPS_AGE_KEY_FILE'"