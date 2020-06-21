defmodule ElixirEcommerce.SubSellTest do
  use ElixirEcommerce.DataCase
  alias ElixirEcommerce.{
    Department,
    Product,
    Sell,
    SubSell,
    UserManager,
    ProductTest
  }

  @user_attrs %{email: "sr.alan.bispo@gmail.com", password: "123456", username: "abmbispo", role: "client"}
  @product_attrs %{name: "NBA shorts", amount: 100, price: 1999}
  @department_attrs %{name: "Sports"}
  @valid_attrs %{amount_sold: 5}

  def sub_sell_fixture do
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@user_attrs)
      |> UserManager.create_user()
    user
  end

  def sell_fixture do
    client = user_fixture()
    assert {:ok, sell} = Sell.create(%{client: client})
    sell
  end

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
      Map.merge(@product_attrs, attrs)
      |> Map.put(:department, department)
      |> Product.create()
    product
  end

  describe "SubSell" do
    test "should be created with valid params" do
      sell = sell_fixture()
      product = product_fixture()

      assert {:ok, sub_sell} =
        @valid_attrs
        |> Map.put(:sell, sell)
        |> Map.put(:product, product)
        |> SubSell.create
    end
  end
end
