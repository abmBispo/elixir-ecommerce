defmodule ElixirEcommerce.Product do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias ElixirEcommerce.{
    ProductImages,
    Repo,
    Department,
    Product,
    ProductImages,
    ElasticsearchCluster,
    ProductAttribute
  }

  @required_fields [:name, :amount, :price, :department, :description]
  @cast_fields [:name, :amount, :price, :description]

  schema "products" do
    field :name, :string
    field :description, :string
    field :amount, :integer
    field :price, :integer
    belongs_to :department, Department
    has_many :images, ProductImages, on_delete: :delete_all
    has_many :attributes, ProductAttribute, on_delete: :delete_all

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
    %Product{}
      |> Product.changeset(attrs)
      |> Repo.insert()
      |> create_product_images(attrs)
      |> create_attributes(attrs)
  end

  def all(params \\ %{page: 1, page_size: 9}) do
    Product
      |> preload(:department)
      |> preload(:images)
      |> order_by(desc: :inserted_at)
      |> Repo.paginate(params)
  end

  def retrieve(ids) when is_list(ids) do
    Product
      |> preload(:department)
      |> where([p], p.id in ^ids)
      |> Repo.all
  end

  def retrieve(id) when is_number(id) do
    Product
      |> preload(:images)
      |> Repo.get!(id)
  end

  def retrieve(id) when is_binary(id) do
    Product
      |> preload(:images)
      |> Repo.get!(id)
  end

  def retrieve(params) do
    Product
      |> preload(:department)
      |> where(^params)
  end

  def text_search(query) do
    {:ok, %{ "hits" => %{ "hits" => search }} } =
      ElasticsearchCluster
      |> Elasticsearch.post("/products/_doc/_search",
        %{
            query: %{
              multi_match: %{
                query: query,
                fields: [:name, :description],
                fuzziness: "AUTO"
              }
            }
          }
        )

    search
      |> Enum.map(fn product -> product["_id"] end)
      |> Product.retrieve()
  end

  def update(%Product{} = product, attrs \\ %{}) do
    product
      |> Product.changeset(attrs)
      |> Repo.update()
  end

  def delete(%Product{} = product) do
    Repo.delete(product)
  end

  defp create_product_images({:error, errors}, attrs), do: {:error, errors}
  defp create_product_images({:ok, product}, attrs) do
    if is_map_key(attrs, :images) do
      Enum.each attrs[:images], fn ({_, image}) ->
        {:ok, _} = ProductImages.create(image: image, product: product)
      end
    end
    {:ok, product}
  end

  defp create_attributes({:error, errors}, attrs), do: {:error, errors, attrs}
  defp create_attributes({:ok, product}, attrs) do
    if is_map_key(attrs, :attributes) do
      Enum.each attrs[:attributes], fn ({_, attribute}) ->
        {:ok, _} = ProductAttribute.create(title: attribute["title"], description: attribute["description"], product: product)
      end
    end
    {:ok, product, attrs}
  end
end
