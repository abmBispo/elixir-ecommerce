defimpl Elasticsearch.Document, for: ElixirEcommerce.Product do
  def id(product), do: product.id

  def routing(_), do: false

  def encode(product) do
    product |> IO.inspect(label: "product")
      %{
          id: product.id,
          name: product.name,
          description: product.description
      }
  end
end
