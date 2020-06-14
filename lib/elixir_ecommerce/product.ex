defmodule ElixirEcommerce.Product do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias ElixirEcommerce.{
    Repo,
    Department,
    Product
  }

  schema "products" do
    field :name, :string
    field :amount, :integer
    field :price, :integer
    belongs_to :department, Department

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    unless is_nil(attrs[:department]) do
      product
      |> cast(attrs, [:name, :amount, :price])
      |> put_assoc(:department, attrs[:department])
      |> validate_required([:name, :amount, :price, :department])
    else
      product
      |> cast(attrs, [:name, :amount, :price])
      |> validate_required([:name, :amount, :price, :department])
    end
  end

  def create(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def all(), do: Repo.all(Product)
  def retrieve(id) when is_integer(id), do: Repo.get!(Product, id)

  def update(%Product{} = product, attrs \\ %{}) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Product{} = product) do
    Repo.delete(product)
  end
end
