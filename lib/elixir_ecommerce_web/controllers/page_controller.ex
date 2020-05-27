defmodule ElixirEcommerceWeb.PageController do
  use ElixirEcommerceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
