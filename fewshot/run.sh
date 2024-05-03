set -eux

# run this after updating drivers, might solve issues when starting a container
# sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml

image=$(dirname $BASH_SOURCE)
docker run \
  --name=$image \
  -dt \
  --volume=$REPOS:/repos \
  --shm-size=2gb \
  --device nvidia.com/gpu=all \
  $image:dev
