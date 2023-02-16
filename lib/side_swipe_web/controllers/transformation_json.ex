defmodule SideSwipeWeb.TransformationJSON do
  @doc """
  Renders a single transformation.
  """
  def show(%{transformation: transformation}) do
    %{data: transformation}
  end
end
