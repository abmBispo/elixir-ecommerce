defmodule ElixirEcommerce.Sell do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sells" do
    field :product_id, :id
    field :client_id, :id

    timestamps()
  end

  @doc false
  def changeset(sell, attrs) do
    sell
    |> cast(attrs, [])
    |> validate_required([])
  end
end
