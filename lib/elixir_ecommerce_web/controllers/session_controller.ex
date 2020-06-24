defmodule ElixirEcommerceWeb.SessionController do
  use ElixirEcommerceWeb, :controller

  alias ElixirEcommerce.{
    UserManager,
    UserManager.User,
    UserManager.Guardian
  }

  def new(conn, _) do
    if Guardian.Plug.current_resource(conn) do
      redirect(conn, to: "/index")
    else
      render(conn,
             "new.html",
             changeset: UserManager.change_user(%User{}),
             action: Routes.session_path(conn, :login))
    end
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    UserManager.authenticate_user(email, password)
      |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
      |> Guardian.Plug.sign_out()
      |> redirect(to: "/index")
  end

  defp login_reply({:ok, user}, conn) do
    conn
      |> put_flash(:info, "Welcome back!")
      |> Guardian.Plug.sign_in(user)
      |> redirect(to: "/index")
  end

  defp login_reply({:error, reason}, conn) do
    conn
      |> put_flash(:error, to_string(reason))
      |> new(%{})
  end
end
