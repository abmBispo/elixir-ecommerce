defmodule ElixirEcommerceWeb.ProductsController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.{
    UserManager.User,
    Product,
    Department
  }

  plug ElixirEcommerceWeb.Authorize, resource: User

  def show(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    departments = Department.all()
    product = Product.retrieve(params["id"])
    render(conn, :show, departments: departments, product: product, current_user: user)
  end
end
