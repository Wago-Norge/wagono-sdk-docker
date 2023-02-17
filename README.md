# wagono-sdk-docker
Build firmware for Wago devices using this docker container. All tooling needed for the build is included.

IMPORTANT! Building firmware on a Mac with Apple Silicon (M1/M2) is not supported due to a library missing arm support.

## Building the Docker image

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

## TA VEKK?? (THORGRIM)
In VSCODE:
- Click the Docker extention icon and select containers.
- Right click the new container and select "Attach Visual Studio Code".

A new VSCODE window will open.
- Open a new terminal and you are ready to continue the build process.

## Instructions CC100 firmware SDK

Clone the firmware SDK repository for CC100
```
git clone https://github.com/Wago-Norge/wagono-ptxdist-config-cc100.git .
```

IMPORTANT! init and update the submodule:
```
./init.sh
```

How to build firmware:
```
./build.sh
```

How to create firmware image:
```
./createimage.sh
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
