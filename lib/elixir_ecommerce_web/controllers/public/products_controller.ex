defmodule ElixirEcommerceWeb.ProductsController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.{
    UserManager,
    UserManager.User,
    Product,
    Department,
    Repo
  }

  def show(conn, params) do
    departments = Department.all()
    product = Product.retrieve(params["id"])
    render(conn, :show, departments: departments, product: product)
  end
end
