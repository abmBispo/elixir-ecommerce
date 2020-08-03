defmodule ElixirEcommerce.Services.ProductService do
  alias ElixirEcommerce.{
    Product,
    Department
  }

  def create(attrs \\ %{}) do
    department =
      String.to_integer(attrs["department_id"])
      |> Department.retrieve()

    {:ok, price} =
      attrs["price"]
      |> Money.parse(:BRL, separator: ".", delimiter: ",")

    product = attrs
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
      |> Map.put(:department, department)
      |> Map.put(:price, price.amount)
      |> Product.create()
  end
end
