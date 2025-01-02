#! /bin/bash
set -ux

if [[ $- =~ i ]]; then
  root_dir=$PWD
else
  root_dir=$(dirname "${BASH_SOURCE[0]}")
fi
source "$root_dir"/common.sh

env_file="$(mktemp)"
envsubst < "$root_dir"/conf.env > "$env_file"
source "$env_file"

PULL_POLICY=${PULL_POLICY:-never}
WORKSPACE=${WORKSPACE:-/workspace}

DOCKER_RUN_ARGS="docker run -dt --pull=$PULL_POLICY --replace"

if [[ ! -v REPOS ]]; then
  REPOS_POTENTIAL_DEFAULT="$HOME/repos"
  if [[ -d "$REPOS_POTENTIAL_DEFAULT" ]]; then
    REPOS="$REPOS_POTENTIAL_DEFAULT"
  fi
fi
if [[ -v REPOS ]]; then
  DOCKER_RUN_ARGS+=" --volume=$REPOS:$WORKSPACE"

  DOTFILES=${DOTFILES:-$REPOS/dotfiles}
fi



if [[ -v IMAGE ]]; then
  # extracts the suffix after the last occurence of a forward slash
  RM_PREFIX="${IMAGE##*/}"
  RM_TAG="${RM_PREFIX%%:*}"
  name="${RM_TAG}_dev"
  DOCKER_RUN_ARGS+=" --name=$name $IMAGE"
elif [[ -v IMAGE_PATH && -d "$IMAGE_PATH" ]]; then
  if [[ -f "$IMAGE_PATH/run.sh" ]]; then
    bash "$IMAGE_PATH/run.sh"
    exit 0
  fi

  image_dir=$(_strip_path "$root_dir" "$IMAGE_PATH")
  name="$image_dir"
  DOCKER_RUN_ARGS+=" --name=$name localhost/$image_dir:dev"
else
  echo 'No IMAGE or IMAGE_PATH provided, exiting...'
  exit 1
fi

DOCKER_RUN="$DOCKER_RUN_ARGS"
$DOCKER_RUN

if [[ -d "$DOTFILES" ]]; then
  for dotfile in "$DOTFILES"/.bash*; do
    docker cp "$dotfile" "$name":/root
  done
fi