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

## Instructions CC100 firmware SDK

Clone the firmware SDK repository for CC100
```
cd /workspaces
git clone https://github.com/Wago-Norge/wagono-ptxdist-config-cc100.git .
```

IMPORTANT! init and update the submodule:
```
./init.sh
```

how to build firmware:
```
./build.sh
```

[optional] list available firmware versions (tags):
```
cd cc100
git tag
```

[optional] select specific firmware version (tag):
```
git checkout <tag>
```


## Instructions TP and Edge controller

Clone the firmware SDK repository for TP and Edge controller
```
cd /workspaces
git clone https://github.com/Wago-Norge/wagono-ptxdist-config-tp-edge.git .
```

IMPORTANT! init and update the submodule:
```
./init.sh
```

how to build firmware:
```
./build.sh
```

[optional] list available firmware versions (tags):
```
cd cc100
git tag
```

[optional] select specific firmware version (tag):
```
git checkout <tag>
```


## Instructions PFC200-G2

Clone the firmware SDK repository for PFC200-G2
```
cd /workspaces
git clone https://github.com/Wago-Norge/wagono-ptxdist-config-pfc200g2.git .
```

IMPORTANT! init and update the submodule:
```
./init.sh
```

how to build firmware:
```
./build.sh
```

[optional] list available firmware versions (tags):
```
cd cc100
git tag
```

[optional] select specific firmware version (tag):
```
git checkout <tag>
```
