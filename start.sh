#!/bin/bash

docker-compose -f docker-compose.yml -f elastic5.yml -f redis.yml -f vsf.yaml up --build