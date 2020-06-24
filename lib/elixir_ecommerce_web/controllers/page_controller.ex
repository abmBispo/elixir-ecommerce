defmodule ElixirEcommerceWeb.PageController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.{
    UserManager,
    UserManager.User,
    Product,
    Department,
    Repo
  }

  def index(conn, _params) do
    products = Product.all()
    departments = Department.all()

    render(conn, "index.html",
      products: products,
      departments: departments)
  end
end
