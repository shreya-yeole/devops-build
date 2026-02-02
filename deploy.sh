#!/bin/bash

#to deploy application need to install docker-compose

sudo apt install docker-compose

echo "run the container"


docker-compose up -d --build

echo "container created successfully"


