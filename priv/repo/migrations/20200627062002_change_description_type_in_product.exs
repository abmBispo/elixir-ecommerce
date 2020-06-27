defmodule ElixirEcommerce.Repo.Migrations.AddDescriptionToProduct do
  use Ecto.Migration

  def change do
    alter table(:products) do
      modify :description, :text
    end
  end
end
