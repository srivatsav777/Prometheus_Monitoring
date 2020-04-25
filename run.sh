#!/bin/bash

sudo docker build --tag monitor .
kubectl create -f create-pod.yml