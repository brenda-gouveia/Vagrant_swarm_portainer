#!/bin/bash

# Só o master executa isso
docker swarm init --advertise-addr 192.168.56.10

# Salva o token em um local acessível
docker swarm join-token worker -q > /vagrant/worker_token

# Cria o serviço do Portainer (interface gráfica para gerenciar o Swarm)
if docker service ls | grep -q portainer; then
  echo "Portainer já está rodando."
else
  echo "Iniciando o Portainer..."
  docker service create \
    --name portainer \
    --publish 9000:9000 \
    --constraint 'node.role == manager' \
    --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
    --mount type=volume,src=portainer_data,dst=/data \
    portainer/portainer-ce
fi