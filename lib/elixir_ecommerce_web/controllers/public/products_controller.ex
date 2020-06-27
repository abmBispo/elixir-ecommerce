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

    render(conn, :show, departments: departments)
  end
end
