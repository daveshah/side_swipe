defmodule SideSwipe.Repo.Migrations.CreateTransformations do
  use Ecto.Migration

  def change do
    create table(:transformations) do
      add :hook, :string, null: false
      add :identifier, :string, null: false
      add :description, :text
      add :template, :text, null: false
      add :published_at, :utc_datetime

      timestamps()
    end
  end
end
