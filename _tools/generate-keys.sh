#!/bin/bash

set -eu

PRIVATE_KEY_OUTPUT_DIR="$1"
PUBLIC_KEY_OUTPUT_DIR="$2"
PRIVATE_KEY_FILENAME="age-key.private"
PUBLIC_KEY_FILENAME="age-key.public"
docker exec -i sopsage /bin/bash -c "age-keygen" > "${PRIVATE_KEY_OUTPUT_DIR}/${PRIVATE_KEY_FILENAME}"
cat "${PRIVATE_KEY_OUTPUT_DIR}/${PRIVATE_KEY_FILENAME}" | grep -oP "public key: \K(.*)" > "${PUBLIC_KEY_OUTPUT_DIR}/${PUBLIC_KEY_FILENAME}"