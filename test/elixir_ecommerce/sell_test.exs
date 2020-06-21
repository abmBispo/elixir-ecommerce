defmodule ElixirEcommerce.SellTest do
  use ElixirEcommerce.DataCase
  alias ElixirEcommerce.{
    Department,
    Product,
    Sell,
    UserManager
  }

  @user_fixture %{email: "sr.alan.bispo@gmail.com", password: "123456", username: "abmbispo", role: "client"}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@user_fixture)
      |> UserManager.create_user()
    user
  end

  def sell_fixture do
    client = user_fixture()
    assert {:ok, sell} = Sell.create(%{client: client})
    sell
  end

  describe "Sell" do
    test "should be created with valid params" do
      client = user_fixture()
      assert {:ok, sell} = Sell.create(%{client: client})
      assert sell.client == client
    end

    test "should not be created with invalid params" do
      assert {:error, _} = Sell.create()
    end

    test "should be retrieved by its UUID" do
      existing_sell = sell_fixture()
      assert retrieved_sell = Sell.retrieve(existing_sell.uuid)
      assert retrieved_sell.client == existing_sell.client
    end

    test "should be retrieved by its ID (PK)" do
      existing_sell = sell_fixture()
      assert retrieved_sell = Sell.retrieve(existing_sell.id)
      assert retrieved_sell.client == existing_sell.client
    end
  end
end
