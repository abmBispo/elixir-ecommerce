defmodule ElixirEcommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, null: false
      add :amount, :integer, null: false
      add :price, :integer, null: false
      add :department_id, references(:departments, on_delete: :nothing)

      timestamps()
    end

  end
end
