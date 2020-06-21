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

  def sell_fixture do
  end

  describe "SubSell" do
    test "should be created with valid params" do
      product = ProductTest.product_fixture()
      sell = SellTest.sell_fixture()

      assert {:ok, sub_sell} =
        @valid_attrs_first
        |> Map.put(:product, product)
        |> Map.put(:sell, sell)
        |> SubSell.create()

      assert sub_sell.product == product
      assert sub_sell.sell == sell
    end

    test "should not be created with invalid params" do
    end

    test "should be updated with valid params" do
    end
  end
end
