defmodule ElixirEcommerceWeb.HomeController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.UserManager.User
  plug ElixirEcommerceWeb.Authorize, resource: User

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", current_user: user)
  end
end
