set -eux

root_dir=$(dirname $BASH_SOURCE)
source $root_dir/conf.env
source $root_dir/common.sh

image_dir=$(_strip_path $root_dir $1)

if [[ -f "$1/run.sh" ]]; then
  source $1/run.sh
else
  # TODO: make pull policy configurable
  docker run -dt \
    --name=$image_dir \
    --pull=never \
    --volume=$HOME/repos:$WORKSPACE \
    localhost/$image_dir:dev
fi
