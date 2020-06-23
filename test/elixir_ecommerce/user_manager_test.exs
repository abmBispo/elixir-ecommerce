defmodule ElixirEcommerce.UserManagerTest do
  use ElixirEcommerce.DataCase

  alias ElixirEcommerce.{
    UserManager,
    Sell
  }

  describe "User" do
    alias ElixirEcommerce.UserManager.User

    @valid_attrs %{email: "sr.alan.bispo@gmail.com", password: "123456", username: "abmbispo", role: "admin"}
    @update_attrs %{email: "bispo@gmail.com", password: "654321", username: "abmBispo"}
    @invalid_attrs %{email: nil, password: nil, username: nil, role: "admin"}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserManager.create_user()
      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert UserManager.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert UserManager.get_user!(user.id) == user
    end

    test "should access all purchases" do
      user = user_fixture()
      assert {:ok, sell_1} = Sell.create(%{client: user})
      assert {:ok, sell_2} = Sell.create(%{client: user})
      assert {:ok, sell_3} = Sell.create(%{client: user})

      uuids =
        user
        |> UserManager.list_purchases()
        |> Enum.map(fn(sell) -> sell.uuid end)

      assert [sell_1.uuid, sell_2.uuid, sell_3.uuid] == uuids
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = UserManager.create_user(@valid_attrs)
      assert user.email == "sr.alan.bispo@gmail.com"
      assert {:ok, user} == Argon2.check_pass(user, "123456", hash_key: :password)
      assert user.username == "abmbispo"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserManager.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = UserManager.update_user(user, @update_attrs)
      assert user.email == "bispo@gmail.com"
      assert {:ok, user} == Argon2.check_pass(user, "654321", hash_key: :password)
      assert user.username == "abmBispo"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = UserManager.update_user(user, @invalid_attrs)
      assert user == UserManager.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = UserManager.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> UserManager.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = UserManager.change_user(user)
    end
  end
end
