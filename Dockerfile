FROM elixir
MAINTAINER james@bowers.dev
RUN mix local.hex --force
RUN mix local.rebar --force

ADD . /app
WORKDIR /app
RUN mix deps.get