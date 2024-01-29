set -eux

image=$(dirname $BASH_SOURCE)
docker run \
  --name=$image \
  -dt \
  --volume=$HOME/repos:$WORKSPACE \
  --shm-size=2gb \
  --device nvidia.com/gpu/all \
  $image:dev
