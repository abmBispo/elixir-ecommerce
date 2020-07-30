defmodule ElixirEcommerce.ProductImages do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias ElixirEcommerce.{
    Uploader.Image,
    ProductImages,
    Product,
    Repo
  }

  schema "product_images" do
    belongs_to :product, Product
    field :image, Image.Type

    timestamps()
  end

  @doc false
  def changeset(product_image, attrs) do
    product_image
      |> cast(attrs, [])
      |> put_assoc(:product, attrs[:product])
      |> cast_attachments(attrs, [:image])
      |> validate_required([:image, :product])
  end

  def create(image: image, product: product) do
    %ProductImages{}
      |> changeset(%{image: image, product: product})
      |> Repo.insert()
  end
end
