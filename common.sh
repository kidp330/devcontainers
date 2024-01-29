set -eux
# only lowercase alphanumerics with _ allowed
NAMING_SCHEMA="[a-z0-9_]+"

_strip_path() {
  local root_dir=$1
  local image_dir=$2
  build_dir=$(realpath --relative-to=$root_dir $image_dir)
  [[ "$build_dir" =~ $NAMING_SCHEMA ]] || exit 1
  echo $build_dir
}
