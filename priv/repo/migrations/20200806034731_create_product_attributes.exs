defmodule ElixirEcommerce.Repo.Migrations.CreateProductAttributes do
  use Ecto.Migration

  def change do
    create table(:product_attributes) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :product_id, references(:products, on_delete: :nothing), null: false

      timestamps()
    end

  end
end
