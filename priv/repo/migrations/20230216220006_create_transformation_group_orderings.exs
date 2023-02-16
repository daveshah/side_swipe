defmodule SideSwipe.Repo.Migrations.CreateTransformationGroupOrderings do
  use Ecto.Migration

  def change do
    create table(:transformation_group_orderings) do
      add :order, :integer

      add :transformation_group_id, references(:transformation_groups, on_delete: :nothing),
        null: false

      add :transformation_id, references(:transformations, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:transformation_group_orderings, [:transformation_group_id])
    create index(:transformation_group_orderings, [:transformation_id])
  end
end
