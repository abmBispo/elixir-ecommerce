defmodule ElixirEcommerceWeb.PageController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.{UserManager, UserManager.User}

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
