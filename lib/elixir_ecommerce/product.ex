defmodule ElixirEcommerce.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__
  alias ElixirEcommerce.Repo
  alias ElixirEcommerce.Department

  schema "products" do
    field :amount, :integer
    field :price, :integer
    belongs_to :department, Department

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:amount, :price, :department])
    |> validate_required([:amount, :price, :department])
  end

  def create(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def all(), do: Repo.all(Product)
  def retrieve(id) when is_integer(id), do: Repo.get!(Product, id)
  def retrieve(attrs = %{name: name}) when is_map(attrs) do
    query = from product in Product,
                 where: product.name == ^name,
                 select: product
    Repo.all(query)
  end

  def update(%Product{} = product, attrs \\ %{}) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%Product{} = product) do
    Repo.delete(product)
  end
end
