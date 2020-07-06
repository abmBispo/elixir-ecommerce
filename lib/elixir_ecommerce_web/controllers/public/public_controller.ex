defmodule ElixirEcommerceWeb.PublicController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.{
    UserManager,
    UserManager.User,
    Product,
    Department,
    Repo
  }

  plug ElixirEcommerceWeb.Authorize, resource: User

  def index(conn, params) do
    departments = Department.all()
    user = Guardian.Plug.current_resource(conn)

    products = if params["department"] do
      Product.retrieve(department_id: params["department"])
      |> Repo.paginate(page: params["page"], page_size: 25)
    else
      Product.all()
    end

    render(conn, "index.html", products: products, departments: departments, current_user: user)
  end
end
