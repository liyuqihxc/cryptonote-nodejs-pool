@echo off

docker run --rm -it -p 8117:8117/tcp -p 3333:3333/tcp -p 5555:5555/tcp -p 7777:7777/tcp -v "/e/documents/visual studio 2015/projects/cryptonote-nodejs-pool/config_examples:/config" cryptonote-nodejs-pool:latest /bin/bash
