defmodule ElixirEcommerce.Uploader.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]
  @extension_whitelist ~w(.jpg .jpeg .gif .png .webp)

  def acl(:original, _), do: :public_read

  def validate({file, _}) do
    file_extension =
      file.file_name
      |> Path.extname
      |> String.downcase

    Enum.member?(@extension_whitelist, file_extension)
  end

  def filename(_, {image, _}) do
    image.file_name
      |> Path.basename('.jpg')
      |> Path.basename('.webp')
  end

  def storage_dir(_, {_, product_image}) do
    "priv/static/images/uploads/products/#{product_image.product_id || product_image.product.id}"
  end

  def default_url(:original) do
    "https://placehold.it/100x100"
  end
end
