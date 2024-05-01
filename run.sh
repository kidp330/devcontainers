set -eux

if [[ ! -v IMAGE_PATH ]]; then 
  echo '$IMAGE_PATH not provided, exiting...'
  exit 1
fi

if [[ ! -v REPOS ]]; then
  REPOS=$HOME/repos
fi

if [[ $- =~ i ]]; then
  root_dir=$PWD
else
  root_dir=$(dirname $BASH_SOURCE)
fi

source $root_dir/conf.env
source $root_dir/common.sh

image_dir=$(_strip_path $root_dir $IMAGE_PATH)

if [[ -f "$IMAGE_PATH/run.sh" ]]; then
  source $IMAGE_PATH/run.sh
else
  # TODO: make replace policy configurable
  docker run -dt \
    --name=$image_dir \
    --pull=$PULL_POLICY \
    --replace \
    --volume=$REPOS:$WORKSPACE \
    --volume=$DOTFILES:/root \
    localhost/$image_dir:dev
fi
