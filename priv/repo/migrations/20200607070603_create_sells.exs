defmodule ElixirEcommerce.Repo.Migrations.CreateSells do
  use Ecto.Migration

  def change do
    create table(:sells) do
      add :client_id, references(:users, on_delete: :nothing), null: false
      add :uuid, :uuid

      timestamps()
    end

    create index(:sells, [:client_id])
    create index(:sells, [:uuid])
  end
end
