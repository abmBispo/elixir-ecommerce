defmodule ElixirEcommerce.Services.ProductService do
  alias ElixirEcommerce.{
    Product,
    Department
  }

  def create(attrs \\ %{}) do
    department =
      String.to_integer(attrs["department_id"])
      |> Department.retrieve()

    product = attrs
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
      |> Map.put(:department, department)
      |> Product.create()
  end
end
