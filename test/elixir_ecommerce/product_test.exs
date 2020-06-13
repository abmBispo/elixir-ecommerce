defmodule ElixirEcommerce.ProductTest do
  use ElixirEcommerce.DataCase
  alias ElixirEcommerce.{
    Department,
    Product
  }

  @department_attrs %{name: "Sports"}
  @valid_attrs_first %{name: "NBA shorts", amount: 100, price: 1999}
  @valid_attrs_second %{name: "NBA shirts", amount: 110, price: 2999}
  @valid_attrs_third %{name: "NBA shoes", amount: 150, price: 5999}
  @update_attrs %{name: "NBA shoes"}
  @invalid_attrs %{name: ""}

  def department_fixture(attrs \\ %{}) do
    {:ok, department} =
      attrs
      |> Enum.into(@department_attrs)
      |> Department.create()
    department
  end

  def product_fixture(attrs \\ %{}) do
    department = department_fixture()
    assert {:ok, product} =
      Map.merge(@valid_attrs_first, attrs)
      |> Map.put(:department, department)
      |> Product.create()
    product
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
      product = product_fixture(%{name: "Real cool name"})
      found_product = Product.retrieve(product.id)
      assert found_product.name == "Real cool name"
    end

    test "Should get all products from specific department" do
      department = department_fixture()
      assert {:ok, _} =
        @valid_attrs_first
        |> Map.put(:department, department)
        |> Product.create()
      assert {:ok, _} =
        @valid_attrs_second
        |> Map.put(:department, department)
        |> Product.create()
      assert {:ok, _} =
        @valid_attrs_third
        |> Map.put(:department, department)
        |> Product.create()

      department = department |> Repo.preload(:products)
      assert (department.products |> Enum.at(0)).name == "NBA shorts"
      assert (department.products |> Enum.at(1)).name == "NBA shirts"
      assert (department.products |> Enum.at(2)).name == "NBA shoes"
      assert (department.products |> Enum.at(3)) == nil
    end

    test "Should update product with valid params" do
      product = product_fixture(%{name: "Real cool name"})
      assert product.name == "Real cool name"
      assert {:ok, product} = Product.update(product, @update_attrs)
      assert product.name == "NBA shoes"
    end

    test "Should not update product with invalid params" do
    end

    test "Should delete product" do
    end
  end
end
