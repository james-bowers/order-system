FROM elixir
MAINTAINER james@ticketbuddy.co.uk
RUN mix local.hex --force

WORKDIR /app