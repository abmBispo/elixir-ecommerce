defmodule ElixirEcommerceWeb.PageView do
  use ElixirEcommerceWeb, :view
  alias ElixirEcommerce.{
    Product,
    Department
  }
  alias ElixirEcommerceWeb.Router.Helpers, as: Routes
  alias ElixirEcommerceWeb.Endpoint

  # Decorate
  def product_price(%Product{} = product) do
    product.price
      |> Money.new(:BRL)
      |> Money.to_string(separator: ".", delimiter: ",")
  end

  # Routing
  def index_by_department(%Department{} = department) do
    Routes.page_path(Endpoint, :index, department: department.id)
  end
end
