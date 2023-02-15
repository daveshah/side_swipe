defmodule SideSwipeWeb.TransformationLive.Index do
  use SideSwipeWeb, :live_view

  alias SideSwipe.Transformations
  alias SideSwipe.Transformations.Transformation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :transformations, Transformations.list_transformations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Transformation")
    |> assign(:transformation, Transformations.get_transformation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Transformation")
    |> assign(:transformation, %Transformation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Transformations")
    |> assign(:transformation, nil)
  end

  @impl true
  def handle_info({SideSwipeWeb.TransformationLive.FormComponent, {:saved, transformation}}, socket) do
    {:noreply, stream_insert(socket, :transformations, transformation)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    transformation = Transformations.get_transformation!(id)
    {:ok, _} = Transformations.delete_transformation(transformation)

    {:noreply, stream_delete(socket, :transformations, transformation)}
  end
end
