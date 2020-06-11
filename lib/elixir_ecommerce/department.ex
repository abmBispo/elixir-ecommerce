defmodule ElixirEcommerce.Department do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

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
    |> unique_constraint(:name)
  end

  def create(attrs \\ %{}) do
    %Department{}
    |> Department.changeset(attrs)
    |> Repo.insert()
  end

  def all(), do: Repo.all(Department)
  def retrieve(id) when is_integer(id), do: Repo.get!(Department, id)
  def retrieve(attrs = %{name: name}) when is_map(attrs) do
    query = from department in Department,
                 where: department.name == ^name,
                 select: department
    Repo.all(query)
  end

  def update(%Department{} = deparment, attrs) do
    deparment
    |> Department.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Department{} = department) do
    Repo.delete(department)
  end
end
