# wagono-sdk-docker
Build firmware for Wago devices

Clone this repository
```
git clone https://github.com/Wago-Norge/wagono-sdk-docker.git
```

Build image
```
cd wago-sdk-docker
docker build -t wagono-sdk-docker:latest .
```

Run container based on built image
```
docker run -d --name wago-sdk-builder wagono-sdk-docker
```

Clone source and config repository
```
# run the following for cc100
cd /workspaces
git clone https://github.com/Wago-Norge/wagono-ptxdist-config-cc100.git .

# run the following for pfc200g2
cd /workspaces
git clone https://github.com/Wago-Norge/wagono-ptxdist-config-pfc200g2.git .

# run the following for tp and edge controller
cd /workspaces
git clone https://github.com/Wago-Norge/wagono-ptxdist-config-tp.git .
```

## TEST 

```mermaid 
graph TD;

    %% FLOW GENERAL:
        Main-branch-->CLiBased;
        Main-branch-->ScriptBased;
        Main-branch-->VsCodeBased;
  
      
        CLiBased<-->UserDev-Branch;
        ScriptBased<-->UserDev-Branch;
        VsCodeBased<-->UserDev-Branch;
```




