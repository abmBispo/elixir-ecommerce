defmodule ElixirEcommerce.Repo.Migrations.CreateSells do
  use Ecto.Migration

  def change do
    create table(:sells) do
      add :product_id, references(:products, on_delete: :nothing)
      add :client_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:sells, [:product_id])
    create index(:sells, [:client_id])
  end
end
