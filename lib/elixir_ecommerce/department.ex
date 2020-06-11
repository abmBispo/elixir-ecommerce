defmodule ElixirEcommerce.Department do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__
  alias ElixirEcommerce.Repo

  schema "departments" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(department, attrs) do
    department
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def create(attrs \\ %{}) do
    %Department{}
    |> Department.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Department{} = deparment, attrs) do
    deparment
    |> Department.changeset(attrs)
    |> Repo.update()
  end
end
