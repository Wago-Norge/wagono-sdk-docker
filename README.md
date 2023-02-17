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
## Connect to the containers shell and continue the SDK build
```
docker exec -it wago-sdk-builder sh
```

## Instructions CC100 (Run these commands inside the container)

Clone the firmware SDK repository for CC100 inside the container
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

