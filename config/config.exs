# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_ecommerce,
  ecto_repos: [ElixirEcommerce.Repo]

# Configures the endpoint
config :elixir_ecommerce, ElixirEcommerceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nRS8J9xSfBCuYhxghDq5vqLZSCYDYPKeFZmEmTxaobU80RoWYmRoJaAMyog+Axsr",
  render_errors: [view: ElixirEcommerceWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirEcommerce.PubSub,
  live_view: [signing_salt: "yyFMRKQQ"]

# no arquivo de configuração de cada ambiente você deve sobrescrever isto se é externo
config :elixir_ecommerce, ElixirEcommerce.UserManager.Guardian,
  issuer: "auth",
  secret_key: "bO3kIaPvhPjapyfYgyAwi8ppL/r+3hTclcAJLShJ5KYslUEYYPrsnEh8z73i3Vm4"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
