# mix run priv/repo/seeds.exs

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
