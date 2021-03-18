defmodule LiberatorTestWeb.FallbackResource do
  import Plug.Conn

  def call(conn, %Ecto.Changeset{} = changeset) do
    data =
      LiberatorTestWeb.ChangesetView.render("error.json", %{changeset: changeset})
      |> Jason.encode!()
    resp(conn, 422, data)
  end
end
