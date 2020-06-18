defmodule ElixirEcommerce.Shipping do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirEcommerce.{
    Sell,
    SubSell
  }

  schema "shipments" do
    field :status, :string
    belongs_to :sell, Sell
    has_many :sub_sells, SubSell

    timestamps()
  end

  @doc false
  def changeset(shipping, attrs) do
    shipping
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
