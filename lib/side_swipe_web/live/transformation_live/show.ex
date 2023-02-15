defmodule SideSwipeWeb.TransformationLive.Show do
  use SideSwipeWeb, :live_view

  alias SideSwipe.Transformations

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:transformation, Transformations.get_transformation!(id))}
  end

  defp page_title(:show), do: "Show Transformation"
  defp page_title(:edit), do: "Edit Transformation"
end
