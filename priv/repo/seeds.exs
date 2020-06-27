# mix run priv/repo/seeds.exs
import Ecto.Query

ElixirEcommerce.UserManager.create_user(%{
  email: "sr.alan.bispo@gmail.com",
  password: "123456",
  username: "abmbispo",
  role: "admin"
})

ElixirEcommerce.Department.create(%{
  name: "Sports"
})

ElixirEcommerce.Department.create(%{
  name: "Eletronics"
})

ElixirEcommerce.Department.create(%{
  name: "Bathroom"
})

ElixirEcommerce.Department.create(%{
  name: "Games"
})

query =
  from ElixirEcommerce.Department,
  order_by: fragment("RANDOM()"),
  limit: 1

Enum.each(0..100, fn(x) ->
  product_names = [
    "NBA shorts",
    "NBA shirts",
    "NBA shoes",
    "Plasma TV",
    "Led Shower",
    "GTA V",
    "PS5",
    "Xbox one"
  ]

  department =
    ElixirEcommerce.Repo.all(query)
    |> List.first

  {:ok, product} =
    %{
      name: "#{Enum.at(product_names, Enum.random(0..7))} - #{x + 1}",
      description: Faker.Lorem.paragraph(Enum.random(15..50)),
      amount: Enum.random(0..100),
      price: Enum.random(1000..25000)
    }
    |> Map.put(:department, department)
    |> ElixirEcommerce.Product.create()

  product
end)
