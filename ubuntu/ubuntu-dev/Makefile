.PHONY: status build run rm showip bindip

IMAGE_NAME = ubuntu-dev:latest
CONTAINER_NAME = dev
BIND_IP = 172.17.0.1
RUN_OPTIONS = '--privileged --net=none -v ~/code:/root/code'

status:
	docker ps -a

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run --name=$(CONTAINER_NAME) $(RUN_OPTIONS) -d $(IMAGE_NAME)

rm:
	docker rm -f $(CONTAINER_NAME)

showip:
	docker inspect -f "{{ .NetworkSettings.IPAddress }}" $(CONTAINER_NAME)

bindip:
	sudo ./bindip.sh $(CONTAINER_NAME) $(BIND_IP)
