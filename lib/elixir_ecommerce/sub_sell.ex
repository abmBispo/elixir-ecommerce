defmodule ElixirEcommerce.SubSell do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirEcommerce.{
    Sell,
    Product,
    Shipping
  }

  schema "sub_sells" do
    field :amount_sold, :integer
    field :status, :integer
    belongs_to :sell, Sell
    belongs_to :product, Product
    belongs_to :shipping, Shipping

    timestamps()
  end

  @doc false
  def changeset(sub_sell, attrs) do
    sub_sell
    |> cast(attrs, [:amount_sold, :status])
    |> validate_required([:amount_sold, :status])
  end
end
