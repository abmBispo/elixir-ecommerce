defmodule ElixirEcommerce.Repo.Migrations.CreateSells do
  use Ecto.Migration

  def change do
    create table(:sells) do
      add :client_id, references(:users, on_delete: :nothing), null: false
      add :uuid, :uuid, null: false, default: fragment("uuid_generate_v4()")

      timestamps()
    end

    create index(:sells, [:client_id])
    create index(:sells, [:uuid])
  end
end
