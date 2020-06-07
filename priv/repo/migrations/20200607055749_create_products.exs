defmodule ElixirEcommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :integer, null: false
      add :amount, :integer, null: false
      add :price, :integer, null: false
      add :department, :string, null: false

      timestamps()
    end

  end
end
