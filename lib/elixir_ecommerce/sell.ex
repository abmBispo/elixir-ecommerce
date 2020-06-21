defmodule ElixirEcommerce.Sell do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  alias ElixirEcommerce.{
    Repo,
    UserManager.User,
    SubSell,
    Sell
  }

  schema "sells" do
    field :uuid, Ecto.UUID
    has_many :sub_sells, SubSell
    belongs_to :client, User

    timestamps()
  end

  @doc false
  def changeset(sell, attrs) do
    sell
    |> cast(attrs, [])
    |> put_assoc(:client, attrs[:client])
    |> put_change(:uuid, Ecto.UUID.generate())
    |> validate_required([:uuid, :client])
  end

  def create(attrs \\ %{}) do
    %Sell{}
    |> Sell.changeset(attrs)
    |> Repo.insert()
  end

  def retrieve(id) when is_integer(id) do
    Sell
    |> Repo.get(id)
    |> Repo.preload(:client)
  end

  def retrieve(uuid) when is_binary(uuid) do
    query = from sell in Sell,
                 where: sell.uuid == ^uuid,
                 select: sell
    query
    |> Repo.all()
    |> Repo.preload(:client)
    |> List.first()
  end

  def delete(%Sell{} = sell) do
    Repo.delete(sell)
  end
end
