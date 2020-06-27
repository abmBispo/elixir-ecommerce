defmodule ElixirEcommerce.Product do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias ElixirEcommerce.{
    ProductImages,
    Repo,
    Department,
    Product
  }

  schema "products" do
    field :name, :string
    field :description, :string
    field :amount, :integer
    field :price, :integer
    belongs_to :department, Department
    has_many :images, ProductImages

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product = unless is_nil(attrs[:department]) do
      product
      |> cast(attrs, [:name, :amount, :price, :description])
      |> put_assoc(:department, attrs[:department])
      |> validate_required([:name, :amount, :price, :department, :description])
    else
      product
      |> cast(attrs, [:name, :amount, :price, :description])
      |> validate_required([:name, :amount, :price, :department, :description])
    end
    # unless is_nil(attrs[:images]) do
    #   attrs[:image] |> Enum.each fn(image) ->
    #     cast_attachments(product, image, [:image])
    #   end
    # end
  end

  def create(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def all(params \\ %{page: 1, page_size: 9}) do
    query =
      Product
      |> preload(:department)
      |> Repo.paginate(params)
  end

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
