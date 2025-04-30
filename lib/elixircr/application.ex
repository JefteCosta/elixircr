defmodule Elixircr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixircrWeb.Telemetry,
      Elixircr.Repo,
      {DNSCluster, query: Application.get_env(:elixircr, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Elixircr.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Elixircr.Finch},
      # Start a worker by calling: Elixircr.Worker.start_link(arg)
      # {Elixircr.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixircrWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Elixircr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixircrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
