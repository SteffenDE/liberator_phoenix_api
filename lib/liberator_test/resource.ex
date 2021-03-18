defmodule LiberatorTest.Resource do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name
    field :email
    field :age, :integer
  end

  def changeset(resource, params \\ %{}) do
    resource
    |> cast(params, [:name, :email, :age])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_inclusion(:age, 18..100)
  end
end
