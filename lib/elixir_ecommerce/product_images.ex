defmodule ElixirEcommerce.ProductImages do
  use Ecto.Schema
  import Ecto.Changeset

  alias ElixirEcommerce.Storage.Image

  schema "product_images" do
    field :image, Image.Type

    timestamps()
  end

  @doc false
  def changeset(product_images, attrs) do
    product_images
    |> cast(attrs, [:image])
    |> validate_required([:image])
  end
end
