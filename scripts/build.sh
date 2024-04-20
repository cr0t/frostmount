#!/bin/bash
#
# Defines docker build process for production ready image of our Elixir app.
#
# We want to define Elixir/Erlang versions in minimum places to improve maintainability, so we use `.env` file and parse
# it to convert to build arguments list.
#
# Example:
#
# $ ./scripts/build.sh ghcr.io/cr0t/my_app:0.3.0
# $ ./scripts/build.sh ghcr.io/cr0t/my_app:0.3.0 --force
# $ ./scripts/build.sh ghcr.io/cr0t/my_app:0.3.0 --force --no-cache
#
# Note: `--no-cache` should always be used only with `--force` going first; `--no-cache` ignores the local cache.

if ! docker version > /dev/null 2>&1; then
  echo "docker is not running. We cannot build release without docker!"
  exit 1
fi

# We expect at least the full image name (including version number)
if [[ $# -lt 1 ]]; then
  echo "Please, provide image name we're building, for example:"
  echo "$0 ghcr.io/cr0t/my_app:0.3.0"
  exit 2
fi

# In addition, we also support --force and --no-cache as extra arguments
if [ -n "$2" ] && [[ $2 == "--force" ]]; then
  FORCE_FLAG=true
else
  FORCE_FLAG=false
fi

if [ -n "$3" ] && [[ $3 == "--no-cache" ]]; then
  NO_CACHE_FLAG=true
else
  NO_CACHE_FLAG=false
fi

# Some information we will need to name and tag the image we're building
IMAGE_NAME=$1
EXISTING_IMAGE_ID=$(docker images -q $IMAGE_NAME 2> /dev/null)

if [ -n "$EXISTING_IMAGE_ID" ] && ! $FORCE_FLAG; then
  echo "The image $IMAGE_NAME already exists: $EXISTING_IMAGE_ID!"
  echo "You can use --force to delete and rebuild it forcefully, or bump the version in mix.exs."
  echo "Note: add --no-cache to tell docker to skip local cache."
  exit 3
fi

BUILD_PLATFORM="linux/amd64"
BUILD_ENV_ARGS=$(for i in `cat .env | grep -v '#'`; do out+="--build-arg $i "; done; echo $out; out="")
BUILD_FLAGS="$BUILD_ENV_ARGS --platform $BUILD_PLATFORM --file Dockerfile "

if $FORCE_FLAG && [ -n "$EXISTING_IMAGE_ID" ]; then
  docker image rm $EXISTING_IMAGE_ID
fi

# NOTE: add `--progress plain` to simplify debugging
if $NO_CACHE_FLAG; then
  docker build $BUILD_FLAGS --no-cache --tag $IMAGE_NAME .
else
  docker build $BUILD_FLAGS --tag $IMAGE_NAME .
fi

# push the image
docker push $IMAGE_NAME
