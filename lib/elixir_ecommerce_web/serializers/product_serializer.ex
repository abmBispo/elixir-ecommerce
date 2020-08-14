defmodule ElixirEcommerce.Serializers.ProductSerializer do
  alias ElixirEcommerce.{
    Product,
    Serializers.DepartmentSerializer
  }

  def serialize(%Product{ name: name, description: description, department: department }) do
    %{
      name: name,
      description: description,
      department: DepartmentSerializer.serialize(department)
    }
  end

  def serialize(products) when is_list(products) do
    Enum.map(products, fn(product) -> serialize(product) end)
  end
end
