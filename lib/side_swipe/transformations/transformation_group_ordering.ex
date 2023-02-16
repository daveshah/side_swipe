defmodule SideSwipe.Transformations.TransformationGroupOrdering do
  use Ecto.Schema
  import Ecto.Changeset

  alias SideSwipe.Transformations.TransformationGroup
  alias SideSwipe.Transformations.Transformation

  schema "transformation_group_orderings" do
    field :order, :integer
    belongs_to :transformation_group, TransformationGroup
    belongs_to :transformation, Transformation

    timestamps()
  end

  @doc false
  def changeset(transformation_group_ordering, attrs) do
    transformation_group_ordering
    |> cast(attrs, [:order])
    |> validate_required([:order])
  end
end
