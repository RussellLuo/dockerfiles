## Usage


### 1. Build the image

    $ make build

### 2. Run the container

    $ make run

### 3. Bind IP (172.17.0.1) to the container

    $ make bindip

### 4. Login to the container and Install development requirements

    $ ssh root@172.17.0.1
    root@ea9de85ab6dd:~# ./install.sh
