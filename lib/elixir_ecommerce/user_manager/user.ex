defmodule ElixirEcommerce.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Argon2

  alias ElixirEcommerce.Sell

  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string
    field :role, :string
    has_many :purchases, Sell, foreign_key: :client_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :role])
    |> validate_required([:username, :email, :password, :role])
    |> validate_inclusion(:role, ["client", "admin"])
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
