defmodule SideSwipe.Transformations.Transformation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transformations" do
    field :description, :string
    field :hook, :string
    field :identifier, :string
    field :published_at, :utc_datetime
    field :template, :string

    timestamps()
  end

  @doc false
  def changeset(transformation, attrs) do
    transformation
    |> cast(attrs, [:hook, :identifier, :description, :template, :published_at])
    |> validate_required([:hook, :identifier, :template])
  end
end
