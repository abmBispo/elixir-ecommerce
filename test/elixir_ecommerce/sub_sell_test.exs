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
  @product_attrs %{name: "NBA shorts", amount: 100, price: 1999, description: Faker.Lorem.paragraph(5)}
  @department_attrs %{name: "Sports"}
  @valid_attrs %{amount_sold: 5}
  @invalid_attrs %{amount_sold: 0}
  @valid_update_attrs %{status: "accepted"}
  @invalid_update_attrs %{status: "not_valid_state"}

  def sub_sell_fixture do
    sell = sell_fixture()
    product = product_fixture()

    assert {:ok, sub_sell} =
      @valid_attrs
      |> Map.put(:sell, sell)
      |> Map.put(:product, product)
      |> SubSell.create

    sub_sell
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

    test "should not be created with invalid params" do
      sell = sell_fixture()
      product = product_fixture()

      assert {:error, _} =
        @invalid_attrs
        |> Map.put(:sell, sell)
        |> Map.put(:product, product)
        |> SubSell.create
    end

    test "should not be created without referenced sell" do
      product = product_fixture()

      assert {:error, _} =
        @valid_attrs
        |> Map.put(:product, product)
        |> SubSell.create
    end

    test "should not be created without referenced product" do
      product = product_fixture()

      assert {:error, _} =
        @invalid_attrs
        |> Map.put(:product, product)
        |> SubSell.create
    end

    test "should be retrieved" do
      created_sub_sell =
        sub_sell_fixture()
        |> Repo.preload([:sell, :product, :shipping])

      assert created_sub_sell == SubSell.retrieve(created_sub_sell.id)
    end

    test "should be updated with valid params" do
      created_sub_sell = sub_sell_fixture()
      assert {:ok, updated_sub_sell} = SubSell.update(created_sub_sell, @valid_update_attrs)
      assert updated_sub_sell.status == "accepted"
    end

    test "should not be updated with invalid params" do
      created_sub_sell = sub_sell_fixture()
      assert {:error, _} = SubSell.update(created_sub_sell, @invalid_update_attrs)
    end

    test "should be deleted" do
      created_sub_sell = sub_sell_fixture()
      assert {:ok, _} = SubSell.delete(created_sub_sell)
    end
  end
end
