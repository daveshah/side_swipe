defmodule SideSwipe.Transformations.TransformationGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transformation_groups" do
    field :description, :string
    field :name, :string
    field :published_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(transformation_group, attrs) do
    transformation_group
    |> cast(attrs, [:name, :published_at, :description])
    |> validate_required([:name, :published_at, :description])
  end
end
