defmodule LiberatorTestWeb.Router do
  use LiberatorTestWeb, :router

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

  scope "/", LiberatorTestWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", LiberatorTestWeb do
    pipe_through :api

    forward "/myresource", MyResource
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiberatorTestWeb do
  #   pipe_through :api
  # end
end
