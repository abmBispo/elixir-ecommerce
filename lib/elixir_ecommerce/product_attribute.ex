defmodule ElixirEcommerce.ProductAttribute do
  use Ecto.Schema
  import Ecto.Changeset

  alias ElixirEcommerce.{
    Product,
    ProductAttribute
  }

  schema "product_attributes" do
    field :description, :string
    field :title, :string
    belongs_to :product, Product

    timestamps()
  end

  @doc false
  def changeset(product_attribute, attrs) do
    product_attribute
      |> cast(attrs, [:title, :description])
      |> validate_required([:title, :description])
  end

  def create(attrs) do
    %ProductAttribute{}
      |> ProductAttribute.changeset(attrs)
      |> Repo.insert()
  end
end
