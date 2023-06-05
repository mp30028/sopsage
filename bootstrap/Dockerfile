FROM ubuntu:23.10
LABEL maintainer="mp30028" \
      email="mp30028@gmail.com" \
      description="Dockerfile to build ubuntu image with sops and age installed"
RUN apt update
RUN apt -y upgrade
RUN apt -y install nano
RUN apt -y install curl
RUN apt -y install age
# SOPS_LATEST_VERSION=$(curl -s "https://api.github.com/repos/mozilla/sops/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
RUN curl -Lo sops.deb "https://github.com/mozilla/sops/releases/latest/download/sops_3.7.3_amd64.deb"
RUN apt --fix-broken install ./sops.deb
RUN rm -rf sops.deb
ENV SOPS_AGE_KEY_FILE=/sopsage-keys/key.txt
ENV EDITOR=nano
ENTRYPOINT ["/bin/bash"]