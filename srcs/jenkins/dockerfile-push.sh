#!/bin/bash
set -e
docker build -t airseneo/jenkins:latest .
docker push airseneo/jenkins
