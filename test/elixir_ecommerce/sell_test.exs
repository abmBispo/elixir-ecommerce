defmodule ElixirEcommerce.SellTest do
  use ElixirEcommerce.DataCase
  alias ElixirEcommerce.{
    Department,
    Product,
    Sell,
    UserManager
  }

  @valid_attrs %{email: "sr.alan.bispo@gmail.com", password: "123456", username: "abmbispo", role: "client"}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_attrs)
      |> UserManager.create_user()
    user
  end

  def sell_fixture do
  end

  describe "Sell" do
    test "should be created with valid params" do
      client = user_fixture()
      assert {:ok, sell} = Sell.create(%{client: client})
      assert sell.client == client
    end

    test "should not be created with invalid params" do
    end

    test "should be updated with valid params" do
    end
  end
end
