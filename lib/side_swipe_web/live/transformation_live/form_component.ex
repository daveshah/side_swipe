defmodule SideSwipeWeb.TransformationLive.FormComponent do
  use SideSwipeWeb, :live_component

  alias SideSwipe.Transformations

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage transformation records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="transformation-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:hook]} type="text" label="Hook" />
        <.input field={@form[:identifier]} type="text" label="Identifier" />
        <.input field={@form[:description]} type="textarea" label="Description" />
        <.input field={@form[:template]} type="textarea" label="Template" />
        <.input field={@form[:published_at]} type="datetime-local" label="Published at" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Transformation</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{transformation: transformation} = assigns, socket) do
    changeset = Transformations.change_transformation(transformation)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"transformation" => transformation_params}, socket) do
    changeset =
      socket.assigns.transformation
      |> Transformations.change_transformation(transformation_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"transformation" => transformation_params}, socket) do
    save_transformation(socket, socket.assigns.action, transformation_params)
  end

  defp save_transformation(socket, :edit, transformation_params) do
    case Transformations.update_transformation(
           socket.assigns.transformation,
           transformation_params
         ) do
      {:ok, transformation} ->
        notify_parent({:saved, transformation})

        {:noreply,
         socket
         |> put_flash(:info, "Transformation updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_transformation(socket, :new, transformation_params) do
    case Transformations.create_transformation(transformation_params) do
      {:ok, transformation} ->
        notify_parent({:saved, transformation})

        {:noreply,
         socket
         |> put_flash(:info, "Transformation created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
