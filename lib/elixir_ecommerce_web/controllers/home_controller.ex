defmodule ElixirEcommerceWeb.HomeController do
  use ElixirEcommerceWeb, :controller
  plug ElixirEcommerceWeb.Authorize, resource: User

  def protected(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "protected.html", current_user: user)
  end
end
