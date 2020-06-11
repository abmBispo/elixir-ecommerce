defmodule ElixirEcommerce.Repo.Migrations.CreateDepartments do
  use Ecto.Migration

  def change do
    create table(:departments) do
      add :name, :string, null: false

      timestamps()
    end

    create index("departments", [:name], unique: true)
  end
end
