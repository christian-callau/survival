defmodule SurvivalWeb.Router do
  use SurvivalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SurvivalWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :require_user do
    plug(SurvivalWeb.AuthPlug)
  end

  pipeline :require_admin do
    plug(SurvivalWeb.AdminPlug)
  end

  scope "/auth", SurvivalWeb do
    pipe_through :browser

    get "/facebook", AuthController, :request
    get "/facebook/callback", AuthController, :callback

    pipe_through :require_user

    delete "/logout", AuthController, :delete
  end

  scope "/", SurvivalWeb do
    pipe_through :browser

    get "/login", PageController, :login

    pipe_through :require_user

    get "/", PageController, :home

    scope "/admin" do
      pipe_through :require_admin

      live "/users", UserLive.Index, :index
      live "/users/new", UserLive.Index, :new
      live "/users/:id/edit", UserLive.Index, :edit

      live "/users/:id", UserLive.Show, :show
      live "/users/:id/show/edit", UserLive.Show, :edit
    end
  end
end
