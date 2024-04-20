#!/bin/bash
#
# Orchestrates the release process:
#
# - prepares data
# - shows notifications
# - bootstraps the image build process (which also pushes container image further)

FULLPATH=$(realpath $0)
SCRIPTS_DIR=$(dirname $FULLPATH)

if [[ $# -lt 1 ]]; then
  echo "Please, provide a repository to be used for the image, for example:"
  echo "$0 ghcr.io/cr0t/frostmount"
  exit 1
fi

REPOSITORY=$1
APP_VERSION=$(grep 'version:' mix.exs | cut -d '"' -f2)
IMAGE_NAME="$REPOSITORY:$APP_VERSION"

# time to build the image and then push it to the registry
$SCRIPTS_DIR/build.sh $IMAGE_NAME --force
