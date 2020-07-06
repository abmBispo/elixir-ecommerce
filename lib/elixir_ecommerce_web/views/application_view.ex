defmodule ElixirEcommerceWeb.ApplicationView do
  alias ElixirEcommerceWeb.Endpoint
  alias ElixirEcommerceWeb.Router.Helpers, as: Routes
  alias ElixirEcommerce.{
    Product,
    Department
  }

  def department_products(%Department{} = department) do
    Routes.public_path(Endpoint, :index, department: department.id)
  end

  def show_product(%Product{} = product) do
    Routes.products_path(Endpoint, :show, product.id)
  end

  def home_path do
    Routes.home_path(Endpoint, :index)
  end

  def session_path do
    Routes.session_path(Endpoint, :new)
  end
end
