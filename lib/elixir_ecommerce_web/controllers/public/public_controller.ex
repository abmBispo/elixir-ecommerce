defmodule ElixirEcommerceWeb.PublicController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.{
    UserManager.User,
    Product,
    Department,
    Repo,
    Serializers.ProductSerializer
  }

  plug ElixirEcommerceWeb.Authorize, resource: User

  def index(conn, params) do
    departments = Department.all()
    user = Guardian.Plug.current_resource(conn)

    sport_department =
      Department.retrieve(%{ name: "Sports" })
      |> List.first()

    games_department =
      Department.retrieve(%{ name: "Games" })
      |> List.first()

    eletronics_department =
      Department.retrieve(%{ name: "Eletronics" })
      |> List.first()

    bathroom_department =
      Department.retrieve(%{ name: "Bathroom" })
      |> List.first()

    products = if params["department"] do
      Product.retrieve(department_id: params["department"])
      |> Repo.paginate(page: params["page"], page_size: 25)
    else
      Product.all()
    end

    render(conn, "index.html",
      products: products,
      current_user: user,
      departments: departments,
      games_department: games_department,
      sport_department: sport_department,
      eletronics_department: eletronics_department,
      bathroom_department: bathroom_department)
  end

  def text_search(conn, params) do
    products = Product.text_search(params["value"])
    json(conn, ProductSerializer.serialize(products))
  end
end
