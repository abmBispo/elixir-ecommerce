defmodule ElixirEcommerce.Authorization do
  alias __MODULE__
  alias ElixirEcommerce.UserManager.User

  defstruct role: nil, create: %{}, read: %{}, update: %{}, delete: %{}

  def grant(role), do: %Authorization{role: role}

  # Enable permissions
  def create!(authorization, resource), do: permit!(authorization, :create, resource)
  def read!(authorization, resource), do: permit!(authorization, :read, resource)
  def update!(authorization, resource), do: permit!(authorization, :update, resource)
  def delete!(authorization, resource), do: permit!(authorization, :delete, resource)
  def all!(authorization, resource) do
    authorization
    |> create!(resource)
    |> read!(resource)
    |> update!(resource)
    |> delete!(resource)
  end

  # Check for permissions
  def create?(authorization, resource), do: Map.get(authorization.create, resource, false)
  def read?(authorization, resource), do: Map.get(authorization.read, resource, false)
  def update?(authorization, resource), do: Map.get(authorization.update, resource, false)
  def delete?(authorization, resource), do: Map.get(authorization.delete, resource, false)

  # Helpers
  defp permit!(authorization, action, resource) do
    updated_read =
      authorization
      |> Map.get(action)
      |> Map.put(resource, true)

    Map.put(authorization, action, updated_read)
  end

  # Defining roles
  def can("client" = role) do
    grant(role)
    |> read!(Product)
    |> read!(User)
  end

  def can("admin" = role) do
    grant(role)
    |> all!(Product)
    |> all!(User)
  end
end
