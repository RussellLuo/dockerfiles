Usage
-----

### 1. Build the image

    $ sudo docker build -t mongodb:dev .

### 2. Run the container

To start a replica set with only one node:

    $ sudo docker run --name mongodb-dev -d -p :27017 mongodb:dev

To start a replica set with three nodes:

    $ sudo docker run --name mongodb-dev -d -e REPLSETMEMBERS=3 -p :27017 -p :27018 -p 27019 mongodb:dev
