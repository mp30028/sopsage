#!/bin/bash

set -eu

ENCRYPTED_CONFIG_FULL_FILEPATH="$1"
#PRIVATE_KEY_FILEPATH="$2"


ENCRYPTED_CONFIG_FILENAME=$(basename -- "$ENCRYPTED_CONFIG_FULL_FILEPATH")
PRIVATE_KEY_FILENAME=$(basename -- "$SOPS_AGE_KEY_FILE")

CONFIG_FILE_DIRECTORY=$(dirname "$ENCRYPTED_CONFIG_FULL_FILEPATH")
CONFIG_FILE_EXTENSION="${ENCRYPTED_CONFIG_FILENAME##*.}"
CONFIG_FILE_NAME_PART="${ENCRYPTED_CONFIG_FILENAME%.enc.*}"

docker cp ${SOPS_AGE_KEY_FILE} sopsage:/tmp/sopsage/work/${PRIVATE_KEY_FILENAME}
docker cp ${ENCRYPTED_CONFIG_FULL_FILEPATH} sopsage:/tmp/sopsage/work/${ENCRYPTED_CONFIG_FILENAME}
docker exec -e SOPS_AGE_KEY_FILE="/tmp/sopsage/work/${PRIVATE_KEY_FILENAME}" sopsage sh -c "sops -d /tmp/sopsage/work/${ENCRYPTED_CONFIG_FILENAME}>/tmp/sopsage/work/${CONFIG_FILE_NAME_PART}.${CONFIG_FILE_EXTENSION}"
#docker exec -e SOPS_AGE_KEY_FILE="/tmp/sopsage/work/${PRIVATE_KEY_FILENAME}" sopsage sh -c "sops -d /tmp/sopsage/work/${ENCRYPTED_CONFIG_FILENAME}"
#docker cp ${PUBLIC_KEY_FILEPATH} sopsage:/tmp/sopsage/work/${PUBLIC_KEY_FILENAME}
#docker exec -i sopsage sh /scripts/encrypt-configs.sh /tmp/sopsage/work/${CONFIG_FILENAME} /tmp/sopsage/work/${PUBLIC_KEY_FILENAME} ${KEYS_TO_ENCRYPT}
docker cp sopsage:/tmp/sopsage/work/${CONFIG_FILE_NAME_PART}.${CONFIG_FILE_EXTENSION} "${CONFIG_FILE_DIRECTORY}/${CONFIG_FILE_NAME_PART}.${CONFIG_FILE_EXTENSION}"