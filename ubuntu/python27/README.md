Usage
-----

### 1. Build the image

    $ docker build -t python27 .

### 2. Run the container

Run a server which is accessible via SSH:

    $ docker run --name python27-server -d python27 /sbin/my_init --enable-insecure-key
