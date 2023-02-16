defmodule SideSwipe.Repo.Migrations.CreateTransformationGroups do
  use Ecto.Migration

  def change do
    create table(:transformation_groups) do
      add :name, :string, null: false
      add :published_at, :utc_datetime
      add :description, :text

      timestamps()
    end
  end
end
