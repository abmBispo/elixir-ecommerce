defmodule ElixirEcommerceWeb.Admin.ProductsView do
  use ElixirEcommerceWeb, :view
  alias ElixirEcommerceWeb.Endpoint
  alias ElixirEcommerceWeb.Router.Helpers, as: Routes
  alias ElixirEcommerce.{
    Product,
    Department,
    ProductsController
  }

  def create_product do
    Routes.admin_products_path(Endpoint, :create)
  end

  def array_input(form, field_name, target) do
    assigns = [
      field_name: field_name,
      form_name: form.name,
      target: target
    ]
    render(ElixirEcommerceWeb.FieldArrayView, "field_array.html", assigns)
  end
end
