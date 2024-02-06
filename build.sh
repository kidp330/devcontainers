set -eux

root_dir=$(dirname $BASH_SOURCE)
source $root_dir/common.sh

build_dir=$(_strip_path $root_dir $1)

# file with required arguments MUST be in the same directory as $BASH_SOURCE
env_file=/tmp/.env_${build_dir}_$(date +%s)
envsubst <$root_dir/conf.env >$env_file
source $env_file

# if [ HOST_CONFIG is set ]
cp -r $HOME/.bash{rc,_aliases,_logout,_profile} $HOST_CONFIG

docker build \
	--build-arg-file=$env_file \
	--tag=$build_dir:dev \
	--label=dev \
	--file=$build_dir/Dockerfile \
	$root_dir
