defmodule TrainSimulator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TrainSimulatorWeb.Telemetry,
      TrainSimulator.Repo,
      {DNSCluster, query: Application.get_env(:train_simulator, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TrainSimulator.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TrainSimulator.Finch},
      # Start a worker by calling: TrainSimulator.Worker.start_link(arg)
      # {TrainSimulator.Worker, arg},
      # Start to serve requests, typically the last entry
      TrainSimulatorWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TrainSimulator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TrainSimulatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
