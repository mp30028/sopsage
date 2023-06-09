# sopsage
Project to demonstrate an approach for managing security with SOPS, AGE, Docker and GitHub

### Approach



![approach](_docs/diagrams/01-approach.png)


#### 1. Setup and installation
The folder setup-sops-and-age contains a docker-compose project which will create an image and then start a container called sopsage with all the tools installed and setup.
To stop and clean up run
```
docker compose down
docker compose rm -f
```
To re-build the image and start the container `docker compose build --no-cache --pull`