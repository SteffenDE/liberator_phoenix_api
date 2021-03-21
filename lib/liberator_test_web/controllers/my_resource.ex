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
        %{resources: LiberatorTest.Repo.all(LiberatorTest.Resource)}

      id ->
        %{resource: LiberatorTest.Repo.get!(LiberatorTest.Resource, id)}
    end
  end

  @impl true
  def post!(_conn) do
    LiberatorTest.Resource.changeset(%LiberatorTest.Resource{}, %{"email" => "abc"})
    |> LiberatorTest.Repo.insert()
  end

  @impl true
  def handle_ok(_conn = %{assigns: %{resources: resources}}), do: resources

  @impl true
  def handle_ok(_conn = %{assigns: %{resource: resource}}), do: resource

  @impl true
  def handle_created(_conn = %{assigns: %{created_resource: resource}}), do: resource

  @impl true
  def handle_error(conn, error, _failed_step),
    do: LiberatorTestWeb.FallbackController.call(conn, error)
end
