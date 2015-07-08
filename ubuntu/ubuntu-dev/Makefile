.PHONY: status build run rm showip bindip

status:
	docker ps -a

build:
	docker build -t ubuntu-dev .

run:
	docker run --net=none --name=dev -v ~/code:/root/code -d ubuntu-dev:latest

rm:
	docker rm -f dev

showip:
	docker inspect -f "{{ .NetworkSettings.IPAddress }}" dev

bindip:
	sudo ./bindip.sh dev 172.17.0.1
