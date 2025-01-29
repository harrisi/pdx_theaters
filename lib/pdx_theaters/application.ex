defmodule PdxTheaters.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PdxTheatersWeb.Telemetry,
      PdxTheaters.Repo,
      {DNSCluster, query: Application.get_env(:pdx_theaters, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PdxTheaters.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PdxTheaters.Finch},
      # Start a worker by calling: PdxTheaters.Worker.start_link(arg)
      # {PdxTheaters.Worker, arg},
      # Start to serve requests, typically the last entry
      PdxTheatersWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PdxTheaters.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PdxTheatersWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
