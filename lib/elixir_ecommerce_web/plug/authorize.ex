defmodule ElixirEcommerceWeb.Authorize do
  import Plug.Conn
  import Phoenix.Controller
  import ElixirEcommerce.Authorization
  alias ElixirEcommerceWeb.Router.Helpers, as: Routes
  alias ElixirEcommerce.UserManager.User

  def init(opts), do: opts

  def call(conn, opts) do
    user = (Guardian.Plug.current_resource(conn) || %User{role: "client"})
    role = user.role
    resource = Keyword.get(opts, :resource)
    action = action_name(conn)

    check(action, role, resource)
    |> continue(conn)
  end

  def continue(true, conn), do: conn
  def continue(false, conn) do
    conn
    |> put_flash(:error, "You're not authorized to access this funcionality")
    |> redirect(to: Routes.public_path(conn, :index))
    |> halt()
  end

  defp check(action, role, resource) when action in [:index, :show, :text_search] do
    can(role) |> read?(resource)
  end

  defp check(action, role, resource) when action in [:new, :create] do
    can(role) |> create?(resource)
  end

  defp check(action, role, resource) when action in [:edit, :update] do
    can(role) |> update?(resource)
  end

  defp check(:delete, role, resource) do
    can(role) |> delete?(resource)
  end

  defp check(_action, _role, _resource), do: false
end
