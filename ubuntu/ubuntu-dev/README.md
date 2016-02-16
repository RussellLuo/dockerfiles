## Usage


### 1. Set your SSH keys

    $ cat ~/.ssh/id_rsa > .ssh/id_rsa
    $ cat ~/.ssh/id_rsa.pub > .ssh/id_rsa.pub

### 2. Build the image

    $ make build

### 3. Run the container

    $ make run

### 4. Bind IP (172.17.0.1) to the container

    $ make bindip

### 5. Login to the container and Install development requirements

    $ ssh root@172.17.0.1
    root@ea9de85ab6dd:~# ./install.sh
