defmodule SideSwipe.TransformationsTest do
  use SideSwipe.DataCase

  alias SideSwipe.Transformations

  describe "apply/1" do
    test "data transformation" do
      %{
        "hook" => "test-hook",
        "identifier" => "test-identifier",
        "template" => """
        {
          "test_sku": "{{order.sku}}"
        }
        """,
        "published_at" => DateTime.utc_now()
      }
      |> Transformations.create_transformation()

      params = %{
        "hook" => "test-hook",
        "identifier" => "test-identifier",
        "data" => %{"order" => %{"sku" => "ABC-123"}}
      }

      res = Transformations.apply(params)

      assert {:ok, %{"test_sku" => "ABC-123"}} = res
    end
  end

  describe "transformations" do
    alias SideSwipe.Transformations.Transformation

    import SideSwipe.TransformationsFixtures

    @invalid_attrs %{
      description: nil,
      hook: nil,
      identifier: nil,
      published_at: nil,
      template: nil
    }

    test "list_transformations/0 returns all transformations" do
      transformation = transformation_fixture()
      assert Transformations.list_transformations() == [transformation]
    end

    test "get_transformation!/1 returns the transformation with given id" do
      transformation = transformation_fixture()
      assert Transformations.get_transformation!(transformation.id) == transformation
    end

    test "create_transformation/1 with valid data creates a transformation" do
      valid_attrs = %{
        description: "some description",
        hook: "some hook",
        identifier: "some identifier",
        published_at: ~U[2023-02-14 21:38:00Z],
        template: "some template"
      }

      assert {:ok, %Transformation{} = transformation} =
               Transformations.create_transformation(valid_attrs)

      assert transformation.description == "some description"
      assert transformation.hook == "some hook"
      assert transformation.identifier == "some identifier"
      assert transformation.published_at == ~U[2023-02-14 21:38:00Z]
      assert transformation.template == "some template"
    end

    test "create_transformation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transformations.create_transformation(@invalid_attrs)
    end

    test "update_transformation/2 with valid data updates the transformation" do
      transformation = transformation_fixture()

      update_attrs = %{
        description: "some updated description",
        hook: "some updated hook",
        identifier: "some updated identifier",
        published_at: ~U[2023-02-15 21:38:00Z],
        template: "some updated template"
      }

      assert {:ok, %Transformation{} = transformation} =
               Transformations.update_transformation(transformation, update_attrs)

      assert transformation.description == "some updated description"
      assert transformation.hook == "some updated hook"
      assert transformation.identifier == "some updated identifier"
      assert transformation.published_at == ~U[2023-02-15 21:38:00Z]
      assert transformation.template == "some updated template"
    end

    test "update_transformation/2 with invalid data returns error changeset" do
      transformation = transformation_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Transformations.update_transformation(transformation, @invalid_attrs)

      assert transformation == Transformations.get_transformation!(transformation.id)
    end

    test "delete_transformation/1 deletes the transformation" do
      transformation = transformation_fixture()
      assert {:ok, %Transformation{}} = Transformations.delete_transformation(transformation)

      assert_raise Ecto.NoResultsError, fn ->
        Transformations.get_transformation!(transformation.id)
      end
    end

    test "change_transformation/1 returns a transformation changeset" do
      transformation = transformation_fixture()
      assert %Ecto.Changeset{} = Transformations.change_transformation(transformation)
    end
  end
end
