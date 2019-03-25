FROM elixir
MAINTAINER james@bowers.dev
RUN mix local.hex --force

WORKDIR /app