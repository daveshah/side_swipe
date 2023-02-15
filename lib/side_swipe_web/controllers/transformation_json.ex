defmodule SideSwipeWeb.TransformationJSON do
  alias SideSwipe.Transformations.Transformation

  @doc """
  Renders a single transformation.
  """
  def show(%{transformation: transformation}) do
    %{data: transformation}
  end
end
