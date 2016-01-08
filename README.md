# docker-swarm-template

## Instructions

1. Get a swarm token by following the steps under "Create a Docker Swarm" on [this page](https://docs.docker.com/swarm/install-w-machine/).
1. Copy `.env.example` to `.env` and add your AWS credentials and swarm token.
1. Load the env variables into your session `export $(cat .env | xargs)`
1. Copy `.env.worker.example` to `.env.worker` and populate the worker's environment variables.
1. Run the start script `./start.sh`

Your swarm will provision and begin executing the worker image.

When you're finished, run the tear-down script to shut down the swarm and deprovision all resources `./stop.sh`

