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
    if is_nil(attrs[:status]) do
      sub_sell
      |> cast(attrs, [:amount_sold, :status])
      |> validate_inclusion(:status, @status_enum)
      |> put_change(:status, List.first(@status_enum))
      |> put_assoc(:sell, attrs[:sell])
      |> put_assoc(:product, attrs[:product])
      |> validate_number(:amount_sold, greater_than: 0)
      |> validate_required([:amount_sold, :status, :sell, :product])
    else
      sub_sell
      |> cast(attrs, [:status])
      |> validate_inclusion(:status, @status_enum)
      |> validate_number(:amount_sold, greater_than: 0)
      |> validate_required([:amount_sold, :status, :sell, :product])
    end
  end

  def create(attrs \\ %{}) do
    %SubSell{}
    |> SubSell.changeset(attrs)
    |> Repo.insert()
  end

  def retrieve(id) when is_integer(id) do
    SubSell
    |> Repo.get(id)
    |> Repo.preload(sell: :client)
    |> Repo.preload(product: :department)
    |> Repo.preload(:shipping)
  end

  def update(%SubSell{} = sub_sell, attrs \\ %{}) do
    sub_sell
    |> SubSell.changeset(attrs)
    |> Repo.update()
  end

  def delete(%SubSell{} = sub_sell) do
    Repo.delete(sub_sell)
  end
end
