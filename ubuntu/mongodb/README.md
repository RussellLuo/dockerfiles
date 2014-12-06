Usage
-----

### 1. Build the image

    $ sudo docker build -t mongodb:dev .

### 2. Run the container

    $ sudo docker run --name mongodb-dev -d mongodb:dev --noprealloc --smallfiles
