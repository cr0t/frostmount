# Dockerfile for Production
#
# Defines the build steps that we need to follow to get built Elixir application in Docker and later run it in
# production. We need to do a few things to prepare a release build:
#
# 0. Install pre-requisites
# 1. Compile static assets (mix assets.deploy)
# 2. Gzip and add fingerprints to these files (part of previous step)
# 3. Compile a release
#
# See https://hexdocs.pm/phoenix/releases.html for more detailed documentation.
#
# Usage:
#
#  * build: podman image build --build-arg ELIXIR_VERSION=1.16.2 ... --tag cr0t/frostmount:0.1.0 .
#  * shell: podman container run --rm -it --entrypoint "" -p 127.0.0.1:4000:4000 cr0t/frostmount sh
#  * run:   podman container run --rm -it -p 127.0.0.1:4000:4000 --name frostmount cr0t/frostmount
#  * exec:  podman container exec -it frostmount sh
#  * logs:  podman container logs --follow --tail 100 frostmount
#
# This file is based on these images (actual versions subject to change):
#
#   - https://hub.docker.com/r/hexpm/elixir/tags - for the build image
#   - https://hub.docker.com/_/alpine?tab=tags&page=1&name=3.19.1 - for the release image
#   - https://pkgs.org/ - resource for finding needed packages
#   - Ex: hexpm/elixir:1.16.2-erlang-26.2.2-alpine-3.19.1

ARG ELIXIR_VERSION
ARG ERLANG_VERSION
ARG ALPINE_VERSION

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${ERLANG_VERSION}-alpine-${ALPINE_VERSION}"
ARG RUNNER_IMAGE="alpine:${ALPINE_VERSION}"

FROM ${BUILDER_IMAGE} as builder

# install build dependencies
RUN apk add --no-cache build-base

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# workaround to build an AMD64 image on M-based macs Docker uses QEMU virtual machines, so we have to pass custom
# ERL_FLAGS to fix segfaults, more info: https://github.com/erlang/otp/pull/6340
ENV ERL_FLAGS="+JMsingle true"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
RUN mkdir config
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

COPY priv priv

COPY lib lib

COPY assets assets

# compile assets
RUN mix assets.deploy

# Compile the release
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

COPY rel rel
RUN mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE}

# install runtime dependencies
RUN apk add --no-cache libstdc++ ncurses-libs tini

USER nobody:nobody

WORKDIR "/app"

# set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:nobody /app/_build/${MIX_ENV}/rel/frostmount ./

# if using an environment that doesn't automatically reap zombie processes, it
# is advised to add an init process (such as tini) as an entrypoint;
# see https://github.com/krallin/tini
ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/app/bin/frostmount", "start"]
