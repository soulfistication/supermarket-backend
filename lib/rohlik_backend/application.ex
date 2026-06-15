defmodule RohlikBackend.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RohlikBackendWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:rohlik_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RohlikBackend.PubSub},
      RohlikBackend.Users,
      RohlikBackendWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RohlikBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RohlikBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
