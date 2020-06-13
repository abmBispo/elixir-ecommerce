defmodule ElixirEcommerce.ProductTest do
  use ElixirEcommerce.DataCase
  alias ElixirEcommerce.{
    Department,
    Product
  }

  @department_attrs %{name: "Sports"}
  @valid_attrs_first %{name: "NBA shorts", amount: 100, price: 1999}
  @valid_attrs_second %{name: "NBA shirts", amount: 100, price: 2999}
  @update_attrs %{name: "Eletronics"}
  @invalid_attrs %{name: ""}

  def department_fixture(attrs \\ %{}) do
    {:ok, department} =
      attrs
      |> Enum.into(@department_attrs)
      |> Department.create()
    department
  end

  describe "products" do
    test "Should create product with valid params" do
      department = department_fixture()

      assert {:ok, product} =
        @valid_attrs_first
        |> Map.put(:department, department)
        |> Product.create()

      assert product.department.name == department.name

      assert {:ok, product} =
        @valid_attrs_second
        |> Map.put(:department, department)
        |> Product.create()

      assert product.department.name == department.name
    end

    test "Should not create product with invalid params" do
      department = department_fixture()

      assert {:error, _} =
        @invalid_attrs
        |> Map.put(:department, department)
        |> Product.create()
    end

    test "Should not create product without department" do
      assert {:error, _} = @valid_attrs_first |> Product.create()
    end

    test "Should retrieve product by its ID" do
    end

    test "Should retrieve products by its names" do
    end

    test "Should get all products from specific department" do
    end

    test "Should update product with valid params" do
    end

    test "Should not update product with invalid params" do
    end

    test "Should delete product" do
    end
  end
end
