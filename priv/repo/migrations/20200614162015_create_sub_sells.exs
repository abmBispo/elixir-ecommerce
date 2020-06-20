defmodule ElixirEcommerce.Repo.Migrations.CreateSubSells do
  use Ecto.Migration

  def change do
    create table(:sub_sells) do
      add :amount_sold, :integer
      add :status, :integer
      add :sell_id, references(:sells, on_delete: :nothing), null: false
      add :product_id, references(:products, on_delete: :nothing), null: false
      add :shipping_id, references(:shipments, on_delete: :nothing)

      timestamps()
    end

    create index(:sub_sells, [:sell_id])
    create index(:sub_sells, [:product_id])
    create index(:sub_sells, [:shipping_id])
  end
end
