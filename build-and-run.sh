#!/bin/bash

docker build -t chrome .
docker run --rm -t -p 9222:9222 chrome
