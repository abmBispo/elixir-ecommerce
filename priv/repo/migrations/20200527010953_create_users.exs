defmodule ElixirEcommerce.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false
      add :role, :string, null: false

      timestamps()
    end
    create index("users", [:email], unique: true)
  end
end
