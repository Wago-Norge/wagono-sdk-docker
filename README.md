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

## instructions cc100

Clone the firmware sdk repository for cc100
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


## instructions tp and edge controller

Clone the firmware sdk repository for tp and edge controller
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


## instructions pfc200-g2

Clone the firmware sdk repository for pfc200-g2
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
