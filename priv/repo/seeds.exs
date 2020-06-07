# mix run priv/repo/seeds.exs

ElixirEcommerce.UserManager.create_user(%{
  email: "sr.alan.bispo@gmail.com",
  password: "123456",
  username: "abmbispo",
  role: "admin"
})
