defmodule Bkmarkus.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Bkmarkus.Repo,
      # Start the Telemetry supervisor
      BkmarkusWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bkmarkus.PubSub},
      # Start the Endpoint (http/https)
      BkmarkusWeb.Endpoint
      # Start a worker by calling: Bkmarkus.Worker.start_link(arg)
      # {Bkmarkus.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bkmarkus.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BkmarkusWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
