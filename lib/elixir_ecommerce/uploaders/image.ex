defmodule ElixirEcommerce.Uploader.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original]
  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  def acl(:original, _), do: :public_read

  def validate({file, _}) do
    file_extension =
      file.file_name
      |> Path.extname
      |> String.downcase

    Enum.member?(@extension_whitelist, file_extension)
  end

  def transform(:thumb, _) do
    {:convert, "-thumbnail 100x100^ -gravity center -extent 100x100 -format png", :png}
  end

  def filename(version, {_, image}) do
    Ecto.UUID.generate()
  end

  def storage_dir(_, {_, product}) do
    "uploads/products"
  end

  def default_url(:original) do
    "https://placehold.it/100x100"
  end
end
