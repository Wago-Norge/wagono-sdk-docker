# wagono-sdk-docker
Build firmware for Wago devices using this docker container. All tooling needed for the build is included.

Clone this repository locally
```
git clone https://github.com/Wago-Norge/wagono-sdk-docker.git
```

Build the docker image
```
cd wago-sdk-docker
docker build -t wagono-sdk-docker:latest .
```

Run a container based on the image built in the previous step
```
docker run -d --name wago-sdk-builder wagono-sdk-docker
```

Clone the firmware sdk repository for the controller of choice
```
# do the following for cc100
cd /workspaces
git clone https://github.com/Wago-Norge/wagono-ptxdist-config-cc100.git .

# do the following for pfc200g2
cd /workspaces
git clone https://github.com/Wago-Norge/wagono-ptxdist-config-pfc200g2.git .

# do the following for tp and edge controller
cd /workspaces
git clone https://github.com/Wago-Norge/wagono-ptxdist-config-tp.git .
```

## instructions cc100
IMPORTANT! init and update the submodule:
```
./init.sh
```

how to build cc100 firmware:
```
./build.sh
```

(optional) list avaiable firmware versions (tags):
```
cd cc100
git tag
```

(optional) select specific firmare version (tag):
```
git checkout <tag>
```

