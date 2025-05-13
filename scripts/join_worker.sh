#!/bin/bash

TOKEN=$(cat /vagrant/worker_token)
MASTER_IP="192.168.56.10"

# Junta ao swarm
docker swarm join --token $TOKEN $MASTER_IP:2377