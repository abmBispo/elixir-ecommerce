defmodule ElixirEcommerce.UserManager.ErrorHandler do
  import Plug.Conn
  import Phoenix.Controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:error, "You must be logged in to proceed!")
    |> redirect(to: "/login")
    |> halt()
  end
end
