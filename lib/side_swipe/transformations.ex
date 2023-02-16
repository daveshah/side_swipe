defmodule SideSwipe.Transformations do
  @moduledoc """
  The Transformations context.
  """

  import Ecto.Query, warn: false
  alias SideSwipe.Repo

  alias SideSwipe.Transformations.Transformation

  def apply(%{"hook" => hook, "identifier" => identifier, "data" => data}) do
    transformation = Repo.get_by(Transformation, hook: hook, identifier: identifier)
    {:ok, template} = Solid.parse(transformation.template)

    Solid.render!(template, data)
    |> to_string()
    |> Jason.decode()
  end

  @doc """
  Returns the list of transformations.

  ## Examples

      iex> list_transformations()
      [%Transformation{}, ...]

  """
  def list_transformations do
    Repo.all(Transformation)
  end

  @doc """
  Gets a single transformation.

  Raises `Ecto.NoResultsError` if the Transformation does not exist.

  ## Examples

      iex> get_transformation!(123)
      %Transformation{}

      iex> get_transformation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transformation!(id), do: Repo.get!(Transformation, id)

  @doc """
  Creates a transformation.

  ## Examples

      iex> create_transformation(%{field: value})
      {:ok, %Transformation{}}

      iex> create_transformation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transformation(attrs \\ %{}) do
    %Transformation{}
    |> Transformation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transformation.

  ## Examples

      iex> update_transformation(transformation, %{field: new_value})
      {:ok, %Transformation{}}

      iex> update_transformation(transformation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transformation(%Transformation{} = transformation, attrs) do
    transformation
    |> Transformation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transformation.

  ## Examples

      iex> delete_transformation(transformation)
      {:ok, %Transformation{}}

      iex> delete_transformation(transformation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transformation(%Transformation{} = transformation) do
    Repo.delete(transformation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transformation changes.

  ## Examples

      iex> change_transformation(transformation)
      %Ecto.Changeset{data: %Transformation{}}

  """
  def change_transformation(%Transformation{} = transformation, attrs \\ %{}) do
    Transformation.changeset(transformation, attrs)
  end
end
