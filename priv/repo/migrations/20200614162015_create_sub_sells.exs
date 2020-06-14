defmodule ElixirEcommerce.Repo.Migrations.CreateSubSells do
  use Ecto.Migration

  def change do
    create table(:sub_sells) do
      add :amount_sold, :integer
      add :status, :integer
      add :sell_id, references(:sells, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)
      add :shipment_id, references(:shipments, on_delete: :nothing)

      timestamps()
    end

    create index(:sub_sells, [:sell_id])
    create index(:sub_sells, [:product_id])
    create index(:sub_sells, [:shipment_id])
  end
end
