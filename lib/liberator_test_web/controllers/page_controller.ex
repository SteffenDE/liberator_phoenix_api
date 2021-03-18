defmodule LiberatorTestWeb.PageController do
  use LiberatorTestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
