defmodule ElixirEcommerceWeb.Admin.ProductsController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.UserManager.User
  plug ElixirEcommerceWeb.Authorize, resource: User

  def new(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, :new, current_user: user)
  end
end
