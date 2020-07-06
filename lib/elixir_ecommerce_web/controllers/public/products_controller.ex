defmodule ElixirEcommerceWeb.ProductsController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.{
    UserManager,
    UserManager.User,
    Product,
    Department,
    Repo
  }

  plug ElixirEcommerceWeb.Authorize, resource: User

  def show(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    departments = Department.all()
    product = Product.retrieve(params["id"])
    render(conn, :show, departments: departments, product: product, current_user: user)
  end
end
