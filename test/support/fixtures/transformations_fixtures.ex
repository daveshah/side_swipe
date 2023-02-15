defmodule SideSwipe.TransformationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SideSwipe.Transformations` context.
  """

  @doc """
  Generate a transformation.
  """
  def transformation_fixture(attrs \\ %{}) do
    {:ok, transformation} =
      attrs
      |> Enum.into(%{
        description: "some description",
        hook: "some hook",
        identifier: "some identifier",
        published_at: ~U[2023-02-14 21:38:00Z],
        template: "some template"
      })
      |> SideSwipe.Transformations.create_transformation()

    transformation
  end
end
