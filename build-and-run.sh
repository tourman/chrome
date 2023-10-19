#!/bin/bash

docker build -t chrome .
docker run --rm -ti -p 9222:9222 chrome
