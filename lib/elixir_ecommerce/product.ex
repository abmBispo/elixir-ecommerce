defmodule ElixirEcommerce.Product do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias ElixirEcommerce.{
    ProductImages,
    Repo,
    Department,
    Product,
    ProductImages
  }

  @required_fields [:name, :amount, :price, :department, :description]
  @cast_fields [:name, :amount, :price, :description]

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
  def changeset(product, attrs) when is_map_key(attrs, :department) do
    product
      |> cast(attrs, @cast_fields)
      |> put_assoc(:department, attrs[:department])
      |> validate_required(@required_fields)
  end

  def changeset(product, attrs) do
    product
      |> cast(attrs, @cast_fields)
      |> validate_required(@required_fields)
  end

  def create(attrs) do
    {:ok, product} =
      %Product{}
      |> Product.changeset(attrs)
      |> Repo.insert()

    if is_map_key(attrs, :images) do
      Enum.each attrs[:images], fn ({_, image}) ->
        {:ok, _} = ProductImages.create(image: image, product: product)
      end
    end

    {:ok, product}
  end

  def all(params \\ %{page: 1, page_size: 9}) do
    Product
      |> preload(:department)
      |> order_by(desc: :inserted_at)
      |> Repo.paginate(params)
  end

  def retrieve(id) when is_number(id), do: Repo.get!(Product, id)
  def retrieve(id) when is_binary(id), do: Repo.get!(Product, id)
  def retrieve(params) do
    Product
      |> preload(:department)
      |> where(^params)
  end

  def update(%Product{} = product, attrs \\ %{}) do
    product
      |> Product.changeset(attrs)
      |> Repo.update()
  end

  def delete(%Product{} = product) do
    Repo.delete(product)
  end
end
