ARG VARIANT="bionic"
ARG NONROOT_USER=vscode
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT} as base
ENV DEBIAN_FRONTEND=noninteractive
ARG NONROOT_USER

RUN apt-get update 
RUN apt-get install -y \
    git \
    software-properties-common \
    curl \
    jq
#Only necessary for use behind a corporate firewall
#RUN curl -ksSL $(curl -ksSL $(curl -ksSL https://artifactory.wago.local/api/storage/certs-generic-prod-local/wago-intercept-certificates?lastModified | jq -r .'uri') | jq -r .'downloadUri') -o /usr/local/share/ca-certificates/wago.crt; exit 0
#RUN curl -ksSL https://artifactory.wago.local/certs-generic-prod/wago-root-certificates/IssuingCA-SVCA01002-SHA256-base64.crt -o /usr/local/share/ca-certificates/IssuingCA.crt; exit 0
#RUN curl -ksSL https://artifactory.wago.local/certs-generic-prod/wago-root-certificates/RootCA-SVCA01001-SHA256-base64.crt -o /usr/local/share/ca-certificates/RootCA.crt; exit 0
#RUN update-ca-certificates

RUN add-apt-repository -y ppa:git-core/ppa 

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

RUN set -x \
    && apt-get install -y --no-install-recommends \
    zip \
    unzip \
    bzip2 \
    man \
    automake \
    bison \
    fakeroot \
    file \
    flex \
    gawk \
    gcc-multilib \
    g++-multilib \
    gettext \
    libconfuse-dev \
    libncurses-dev \
    libffi-dev \
    make \
    patch \
    quilt \
    pkg-config \
    python-dev \
    texinfo \
    wget \
    dialog \
    rsync \
    xmlstarlet \
    xsltproc \
    bc \
    lzop \
    net-tools \
    libxml2-utils \
    autopoint \
    libxml-parser-perl \
    python-libxml2 \
    python-mako \
    python3-setuptools \
    ccache \
    ssh \
    x11proto-core-dev \
    # added for cc100
    libncurses5-dev \
    g++ \
    libc6-dev \
    autoconf \
    libtool \
    libgmp-dev \
    libmpc-dev \
    # added for xxd
    vim-common \
    # added for ptxdist documentation build
    python-docutils \
    # added for mkimage
    u-boot-tools \
    doxygen 

RUN apt-get install -y --no-install-recommends \
    git-lfs \
    git-svn \
    subversion

RUN git lfs install
RUN git clone https://github.com/wago/gcc-toolchain-2019.12-precompiled.git /opt/gcc-Toolchain-2019.12/
RUN rm -r /opt/gcc-Toolchain-2019.12/.git
RUN git clone https://github.com/wago/ptxdist.git /ptxdist
RUN cd /ptxdist && git checkout Update-2020.08.0
RUN git clone https://github.com/Wago-Norge/wagono-ptxdist-config-cc100.git /workspaces/cc100

RUN cd /ptxdist \
    && ./configure \
    && make \
    && make install \
    && rm -r /ptxdist

COPY resources /

RUN wget https://github.com/GitTools/GitVersion/releases/download/5.10.3/gitversion-linux-x64-5.10.3.tar.gz
RUN tar -xvf gitversion-linux-x64-5.10.3.tar.gz
RUN mv gitversion /usr/local/bin
RUN chown ${NONROOT_USER} /usr/local/bin/gitversion
RUN rm gitversion-linux-x64-5.10.3.tar.gz

# Install Docker CE CLI
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 lsb-release \
    && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce-cli

# Install Docker Compose
RUN LATEST_COMPOSE_VERSION=$(curl -sSL "https://api.github.com/repos/docker/compose/releases/latest" | grep -o -P '(?<="tag_name": ").+(?=")') \
    && curl -sSL "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose


RUN echo "#!/bin/sh\n\
    sudoIf() { if [ \"\$(id -u)\" -ne 0 ]; then sudo \"\$@\"; else \"\$@\"; fi }\n\
    SOCKET_GID=\$(stat -c '%g' /var/run/docker.sock) \n\
    if [ \"${SOCKET_GID}\" != '0' ]; then\n\
    if [ \"\$(cat /etc/group | grep :\${SOCKET_GID}:)\" = '' ]; then sudoIf groupadd --gid \${SOCKET_GID} docker-host; fi \n\
    if [ \"\$(id ${NONROOT_USER} | grep -E \"groups=.*(=|,)\${SOCKET_GID}\(\")\" = '' ]; then sudoIf usermod -aG \${SOCKET_GID} ${NONROOT_USER}; fi\n\
    fi\n\
    exec \"\$@\"" > /usr/local/share/docker-init.sh \
    && chmod +x /usr/local/share/docker-init.sh

RUN rm -rf /var/lib/apt/lists/*


FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT} as final
ARG NONROOT_USER
LABEL maintainer="dirk.meihoefer@wago.com, sergei.ikkert@wago.com"
COPY --from=base / /
USER ${NONROOT_USER}
WORKDIR /workspaces
# VS Code overrides ENTRYPOINT and CMD when executing `docker run` by default.
# Setting the ENTRYPOINT to docker-init.sh will configure non-root access to
# the Docker socket if "overrideCommand": false is set in devcontainer.json.
# The script will also execute CMD if you need to alter startup behaviors.
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]
