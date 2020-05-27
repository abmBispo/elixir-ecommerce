defmodule ElixirEcommerce.Repo do
  use Ecto.Repo,
    otp_app: :elixir_ecommerce,
    adapter: Ecto.Adapters.Postgres
end
