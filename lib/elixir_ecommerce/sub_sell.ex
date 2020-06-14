defmodule ElixirEcommerce.SubSell do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sub_sells" do
    field :amount_sold, :integer
    field :status, :integer
    field :sell, :id
    field :product, :id
    field :shipments, :id

    timestamps()
  end

  @doc false
  def changeset(sub_sell, attrs) do
    sub_sell
    |> cast(attrs, [:amount_sold, :status])
    |> validate_required([:amount_sold, :status])
  end
end
