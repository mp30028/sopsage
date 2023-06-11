docker cp $SOPS_AGE_KEY_FILE sopsage:/sopsage/configs/dev-server-1/age-key.private
docker exec -i sopsage /bin/bash -c "export $SOPS_AGE_KEY_FILE=/sopsage/configs/dev-server-1/age-key.private"