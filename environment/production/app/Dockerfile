FROM elixir:1.18.3-otp-27 AS build

ENV MIX_ENV=prod \
    LANG=C.UTF-8

WORKDIR /app

RUN apt-get update -y && \
    apt-get install -y build-essential npm postgresql-client git

COPY mix.exs mix.lock ./
COPY config config
RUN mix local.hex --force && mix local.rebar --force && mix deps.get --only $MIX_ENV

COPY . .
RUN mix assets.deploy
RUN mix compile
RUN mix release
RUN ls -la _build/prod/rel/elixircr/bin
# Final stage
FROM elixir:1.18.3-otp-27 AS app

# RUN apt-get update -y && \
#     apt-get install -y libssl-dev openssl libncurses5 && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=build /app/_build/prod/rel/* ./
COPY .env .env

EXPOSE 4001
CMD ["bin/elixircr", "start"]
