defmodule ElixirEcommerce.Sell do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirEcommerce.SubSell

  schema "sells" do
    has_many :sub_sells, SubSell
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
