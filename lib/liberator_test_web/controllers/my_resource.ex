defmodule LiberatorTestWeb.MyResource do
  use Liberator.Resource

  @impl true
  def allowed_methods(_), do: ["POST", "GET"]

  @impl true
  def available_media_types(_), do: ["application/json"]

  @impl true
  def exists?(conn) do
    id = List.last(conn.path_info)

    case id do
      nil ->
        %{resources: []}

      id ->
        try do
          raise Ecto.NoResultsError
        rescue
          Ecto.NoResultsError -> false
          ArgumentError -> false
        else
          resource -> %{resource: resource}
        end
    end
  end

  @impl true
  def post!(conn) do
    with {:ok, resource} <- LiberatorTest.Resource.changeset(%LiberatorTest.Resource{}, %{"email" => "abc"}) do
      %{created_resource: resource}
    else
      %{error: other} -> %{error: other}
      other -> %{error: other}
    end
  end

  @impl true
  def handle_ok(_conn = %{assigns: %{resources: resources}}), do: resources

  @impl true
  def handle_ok(_conn = %{assigns: %{resource: resource}}), do: resource

  @impl true
  def handle_created(_conn = %{assigns: %{created_resource: resource}}), do: resource

  @impl true
  def handle_created(conn = %{assigns: %{error: error}}) do
    conn = LiberatorTestWeb.FallbackResource.call(conn, error)
    IO.inspect(conn, label: "returned from handle_created")
    conn
  end

  @impl true
  def handle_error(conn, error, failed_step) do
    IO.inspect(error, label: "err")
    IO.inspect(failed_step)
    resp(conn, 500, "Internal Server Error")
  end
end
