defmodule Elasticsearch.ElasticsearchStore do
  @behaviour Elasticsearch.Store

  import Ecto.Query
  alias ElixirEcommerce.Repo

  @impl true
  def stream(schema) do
    Repo.stream(schema)
  end

  @impl true
  def transaction(fun) do
    {:ok, result} = Repo.transaction(fun, timeout: :infinity)
    result
  end
end
