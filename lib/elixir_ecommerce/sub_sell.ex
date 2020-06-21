defmodule ElixirEcommerce.SubSell do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirEcommerce.{
    Repo,
    Sell,
    Product,
    Shipping,
    SubSell
  }

  @status_enum ["in_analysis", "accepted", "sent", "delivered"]

  schema "sub_sells" do
    field :amount_sold, :integer
    field :status, :string
    belongs_to :sell, Sell
    belongs_to :product, Product
    belongs_to :shipping, Shipping

    timestamps()
  end

  @doc false
  def changeset(sub_sell, attrs) do
    sub_sell
    |> cast(attrs, [:amount_sold, :status])
    |> validate_inclusion(:status, @status_enum)
    |> put_change(:status, List.first(@status_enum))
    |> put_assoc(:sell, attrs[:sell])
    |> put_assoc(:product, attrs[:product])
    |> validate_required([:amount_sold, :status, :sell, :product])
  end

  def create(attrs \\ %{}) do
    %SubSell{}
    |> SubSell.changeset(attrs)
    |> Repo.insert()
  end
end
