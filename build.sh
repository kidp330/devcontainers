set -eux

root_dir=$(dirname $BASH_SOURCE)
source $root_dir/common.sh

# file with required arguments MUST be in the same directory as $BASH_SOURCE
env_file=$root_dir/conf.env
[[ -f $env_file ]] || exit 1

build_dir=$(_strip_path $root_dir $1)

docker build \
	--build-arg-file=$env_file \
	--tag=$build_dir:dev \
	--label=dev \
	$build_dir
