defmodule SideSwipe.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SideSwipeWeb.Telemetry,
      # Start the Ecto repository
      SideSwipe.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SideSwipe.PubSub},
      # Start Finch
      {Finch, name: SideSwipe.Finch},
      # Start the Endpoint (http/https)
      SideSwipeWeb.Endpoint
      # Start a worker by calling: SideSwipe.Worker.start_link(arg)
      # {SideSwipe.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SideSwipe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SideSwipeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
