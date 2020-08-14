defmodule ElixirEcommerce.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ElixirEcommerce.Repo,
      # Start the Telemetry supervisor
      ElixirEcommerceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ElixirEcommerce.PubSub},
      # Start the Endpoint (http/https)
      ElixirEcommerceWeb.Endpoint,
      # Elastic search cluster
      ElixirEcommerce.ElasticsearchCluster
      # Start a worker by calling: ElixirEcommerce.Worker.start_link(arg)
      # {ElixirEcommerce.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirEcommerce.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirEcommerceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
