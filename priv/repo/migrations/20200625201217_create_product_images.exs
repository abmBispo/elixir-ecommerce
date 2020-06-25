defmodule ElixirEcommerce.Repo.Migrations.CreateProductImages do
  use Ecto.Migration

  def change do
    create table(:product_images) do
      add :image, :string

      timestamps()
    end

  end
end
