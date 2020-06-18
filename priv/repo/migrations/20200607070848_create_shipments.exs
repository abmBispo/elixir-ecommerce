defmodule ElixirEcommerce.Repo.Migrations.CreateShipments do
  use Ecto.Migration

  def change do
    create table(:shipments) do
      add :status, :string, null: false
      add :sell_id, references(:sells, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:shipments, [:sell_id])
  end
end
