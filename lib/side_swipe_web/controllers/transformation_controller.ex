defmodule SideSwipeWeb.TransformationController do
  use SideSwipeWeb, :controller

  alias SideSwipe.Transformations

  action_fallback SideSwipeWeb.FallbackController

  def create(conn, transformation_params) do
    with {:ok, transformation} <- Transformations.apply(transformation_params) do
      conn
      |> put_status(:ok)
      |> render(:show, transformation: transformation)
    end
  end
end
