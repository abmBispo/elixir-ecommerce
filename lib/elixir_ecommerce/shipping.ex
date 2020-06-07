defmodule ElixirEcommerce.Shipping do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shipments" do
    field :status, :string
    field :sell_id, :id

    timestamps()
  end

  @doc false
  def changeset(shipping, attrs) do
    shipping
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
