defmodule ElixirEcommerceWeb.Admin.ProductsController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.{
    UserManager.User,
    Product
  }
  plug ElixirEcommerceWeb.Authorize, resource: User

  def new(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    changeset =
      %Product{}
      |> Product.changeset(%{})
    render(conn, :new, current_user: user, changeset: changeset)
  end

  def create(conn, params) do
    params |> IO.inspect(label: 'params')
  end
end
