defmodule ElixirEcommerceWeb.HomeView do
  use ElixirEcommerceWeb, :view
  alias ElixirEcommerceWeb.Endpoint
  alias ElixirEcommerceWeb.Router.Helpers, as: Routes

  def new_product do
    Routes.admin_products_path(Endpoint, :new)
  end
end
