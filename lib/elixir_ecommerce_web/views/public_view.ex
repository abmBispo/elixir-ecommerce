defmodule ElixirEcommerceWeb.PublicView do
  use ElixirEcommerceWeb, :view
  alias ElixirEcommerce.{
    Product,
    Department
  }

  # Decorate
  def product_price(%Product{} = product) do
    product.price
      |> Money.new(:BRL)
      |> Money.to_string(separator: ".", delimiter: ",")
  end
end
