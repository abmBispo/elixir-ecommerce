defmodule ElixirEcommerce.Repo.Migrations.AddDescriptionToProduct do
  use Ecto.Migration

  def change do
    alter table("products") do
      add :description, :string
    end
  end
end
