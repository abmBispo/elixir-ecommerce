defmodule ElixirEcommerce.SellTest do
  use ElixirEcommerce.DataCase
  alias ElixirEcommerce.{
    Department,
    Product,
    Sell,
    ProductTest
  }

  def sub_sell_fixture do
  end

  describe "Sell" do
    test "should be created with valid params" do
      assert {:ok, product} =
        @valid_attrs_first
        |> Map.put(:department, department)
        |> Product.create()
      assert product.department.name == department.name
    end

    test "should not be created with invalid params" do
    end

    test "should be updated with valid params" do
    end
  end
end
