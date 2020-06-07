defmodule ElixirEcommerce.AuthorizationTest do
  use ExUnit.Case
  import ElixirEcommerce.Authorization, except: [can: 1]
  alias ElixirEcommerce.Product
  alias ElixirEcommerce.User

  def can("user" = role) do
    grant(role)
    |> read!(Product)
  end

  def can("admin" = role) do
    grant(role)
    |> all!(Product)
    |> all!(User)
  end

  # Testing for user role
  test "user cannot create resource" do
    refute can("user") |> create?(Product)
  end

  test "user can read resource" do
    assert can("user") |> read?(Product)
  end

  test "user cannot update resource" do
    refute can("user") |> update?(Product)
  end

  test "user cannot delete resource" do
    refute can("user") |> delete?(Product)
  end

  # Testing for admin role
  test "admin can create resource" do
    assert can("admin") |> create?(Product)
  end

  test "admin can read resource" do
    assert can("admin") |> read?(Product)
  end

  test "admin can update resource" do
    assert can("admin") |> update?(Product)
  end

  test "admin can delete resource" do
    assert can("admin") |> delete?(Product)
  end
end
