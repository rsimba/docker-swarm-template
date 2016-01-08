#!/bin/bash

docker-machine create \
        -d amazonec2 \
        --amazonec2-access-key "$AWS_ACCESS_KEY" \
        --amazonec2-secret-key "$AWS_ACCESS_SECRET" \
        --amazonec2-vpc-id "$EC2_VPC_ID" \
        --swarm \
        --swarm-master \
        --swarm-discovery token://$SWARM_TOKEN \
        scrape-swarm-master

seq 1 $CLUSTER_SIZE | \
awk '{ print "scrape-swarm-worker-" $1 }' | \
xargs -n 1 -P $EC2_PARALLELISM \
  docker-machine create \
        -d amazonec2 \
        --amazonec2-access-key "$AWS_ACCESS_KEY" \
        --amazonec2-secret-key "$AWS_ACCESS_SECRET" \
        --amazonec2-vpc-id "$EC2_VPC_ID" \
        --swarm \
        --swarm-discovery token://$SWARM_TOKEN

eval $(docker-machine env --swarm scrape-swarm-master)

docker-compose up -d
docker-compose scale worker=$CLUSTER_SIZE
