#!/bin/bash

mkdir -p logs

echo "Starting Terratestâ€¦"
cd tests 
env $(cat ../.env | xargs) go test -timeout 90m 
cd ..
