defmodule ElixirEcommerceWeb.Admin.ProductsController do
  use ElixirEcommerceWeb, :controller
  alias ElixirEcommerce.{
    UserManager.User,
    Product,
    Department,
    Services.ProductService
  }
  plug ElixirEcommerceWeb.Authorize, resource: User

  def new(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    changeset =
      %Product{}
      |> Product.changeset(%{})
    departments =
      Department.all()
      |> Enum.map(fn department -> {department.name, department.id} end)

    render(conn, :new, current_user: user, departments: departments, changeset: changeset)
  end

  def create(conn, params) do
    ProductService.create(params["product"])
      |> create_reply(conn)
  end

  defp create_reply({:ok, product}, conn) do
    conn
      |> put_flash(:info, "Successful product creation!")
      |> redirect(to: "/")
      |> halt()
  end

  defp create_reply({:error, errors}, conn) do
    conn
      |> put_flash(:error, "Unsuccessful product creation! Errors #{to_string(errors)}")
      |> new(%{})
  end
end
