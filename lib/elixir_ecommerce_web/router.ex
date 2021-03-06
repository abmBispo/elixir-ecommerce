defmodule ElixirEcommerceWeb.Router do
  use ElixirEcommerceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ElixirEcommerceWeb.Telemetry
    end
  end

  # Our pipeline implements "maybe" authenticated. We'll use the `:ensure_auth` below for when we need to make sure someone is logged in.
  pipeline :auth do
    plug ElixirEcommerce.UserManager.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :login_layout do
    plug :put_layout, {LayoutView, :login}
  end

  scope "/", ElixirEcommerceWeb do
    pipe_through [:auth, :api]
    get "/text-search", PublicController, :text_search
  end

  # Maybe logged in routes
  scope "/", ElixirEcommerceWeb do
    pipe_through [:browser, :auth]

    get "/", PublicController, :index
    get "/index", PublicController, :index

    resources "/products", ProductsController, only: [:show]

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    post "/logout", SessionController, :logout
  end

  # Definitely logged in scope
  scope "/", ElixirEcommerceWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/home", HomeController, :index
  end


  # Definitely logged in scope
  scope "/admin", ElixirEcommerceWeb.Admin, as: :admin do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/products/new", ProductsController, :new
    post "/products/create", ProductsController, :create
  end
end
