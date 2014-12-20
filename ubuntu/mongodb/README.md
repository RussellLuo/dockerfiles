Usage
-----

### 1. Build the image

    $ sudo docker build -t mongodb:dev .

### 2. Run the container

To start a replica set with only one node:

    $ sudo docker run --name mongodb-dev -p :27017 -d mongodb:dev

To start a replica set (named `test_rs`) with three nodes:

    $ sudo docker run --name mongodb-dev -e REPLSETNAME=test_rs -e REPLSETMEMBERS=3 -p :27017 -p :27018 -p 27019 -d mongodb:dev

To start a replica set with authentication (one node):

    $ sudo docker run --name mongodb-dev -e AUTH=true -e USERNAME=root -e PASSWORD=root -p :27017 -d mongodb:dev
