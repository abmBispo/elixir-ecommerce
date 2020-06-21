defmodule ElixirEcommerce.Sell do
  use Ecto.Schema
  import Ecto.Changeset
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
end
