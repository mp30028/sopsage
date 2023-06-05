# Bootstrap
Orchestration to start a docker container with all the necessary tooling setup and installed ready for use on the server where credentials are to be setup and used.

## Bootstrapping SOPS and AGE with a Docker container 
1. Change directory `cd path\to\bootstrap` folder where these notes are stored

2. Build image using the Dockerfile `docker build --no-cache -t ubuntu-sops .`

3. Create a container from the image

```
docker run -it --rm --name=docker-sops -v G:\tmp\sops-keys\key.txt:/sops-keys/key.txt -v G:\tmp\sops-data:/sops-data ubuntu-sops
```
4. Starting the container should bring up an bash command prompt. 

5. Run `sops /sops-data/sample.enc.env` at bash prompt. It should open a decrypted version of the sample in nano.

6. To confirm that the sample is encrypted run `cat /sops-data/sample.enc.env`. All the sensitive values should be encrypted



## Bootstrapping SOPS and AGE manually

### Install SOPS manually

1. Install curl<br/>
`apt update && apt upgrade`
`apt install curl`

2. Get SOPS Version and store it in a shell variable<br/>
`SOPS_LATEST_VERSION=$(curl -s "https://api.github.com/repos/mozilla/sops/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')`

3. Check the SOPS version<br/>
`echo $SOPS_LATEST_VERSION`

4. Use curl to download the latest version for ubuntu/debian<br/>
`curl -Lo sops.deb "https://github.com/mozilla/sops/releases/latest/download/sops_${SOPS_LATEST_VERSION}_amd64.deb"`

5.Install the downloaded package along with any missing dependencies<br/>


6. Clean up download<br/>
`rm -rf sops.deb`

7. Test sops is working<br/>
`sops -version`

8. In case uninstall is needed<br/>
`apt remove sops`

### Install AGE manually (if not already there)
1. Check installation <br/>
`age --version`

2. If installation needed<br/>
 `apt install age`