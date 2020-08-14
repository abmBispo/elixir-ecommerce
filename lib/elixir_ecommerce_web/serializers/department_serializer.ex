defmodule ElixirEcommerce.Serializers.DepartmentSerializer do
  alias ElixirEcommerce.Department

  def serialize(%Department{ name: name }), do: %{ name: name }

  def serialize(departments) when is_list(departments) do
    Enum.map(departments, fn(department) -> serialize(department) end)
  end
end
