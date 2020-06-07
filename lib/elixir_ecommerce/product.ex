defmodule ElixirEcommerce.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :amount, :integer
    field :department, :string
    field :price, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:amount, :price, :department])
    |> validate_required([:amount, :price, :department])
  end
end
