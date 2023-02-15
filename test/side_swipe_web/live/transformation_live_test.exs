defmodule SideSwipeWeb.TransformationLiveTest do
  use SideSwipeWeb.ConnCase

  import Phoenix.LiveViewTest
  import SideSwipe.TransformationsFixtures

  @create_attrs %{
    description: "some description",
    hook: "some hook",
    identifier: "some identifier",
    published_at: "2023-02-14T21:38:00Z",
    template: "some template"
  }
  @update_attrs %{
    description: "some updated description",
    hook: "some updated hook",
    identifier: "some updated identifier",
    published_at: "2023-02-15T21:38:00Z",
    template: "some updated template"
  }
  @invalid_attrs %{description: nil, hook: nil, identifier: nil, published_at: nil, template: nil}

  defp create_transformation(_) do
    transformation = transformation_fixture()
    %{transformation: transformation}
  end

  describe "Index" do
    setup [:create_transformation]

    test "lists all transformations", %{conn: conn, transformation: transformation} do
      {:ok, _index_live, html} = live(conn, ~p"/admin/transformations")

      assert html =~ "Listing Transformations"
      assert html =~ transformation.description
    end

    test "saves new transformation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/transformations")

      assert index_live |> element("a", "New Transformation") |> render_click() =~
               "New Transformation"

      assert_patch(index_live, ~p"/admin/transformations/new")

      assert index_live
             |> form("#transformation-form", transformation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#transformation-form", transformation: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/transformations")

      html = render(index_live)
      assert html =~ "Transformation created successfully"
      assert html =~ "some description"
    end

    test "updates transformation in listing", %{conn: conn, transformation: transformation} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/transformations")

      assert index_live
             |> element("#transformations-#{transformation.id} a", "Edit")
             |> render_click() =~
               "Edit Transformation"

      assert_patch(index_live, ~p"/admin/transformations/#{transformation}/edit")

      assert index_live
             |> form("#transformation-form", transformation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#transformation-form", transformation: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/admin/transformations")

      html = render(index_live)
      assert html =~ "Transformation updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes transformation in listing", %{conn: conn, transformation: transformation} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/transformations")

      assert index_live
             |> element("#transformations-#{transformation.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#transformations-#{transformation.id}")
    end
  end

  describe "Show" do
    setup [:create_transformation]

    test "displays transformation", %{conn: conn, transformation: transformation} do
      {:ok, _show_live, html} = live(conn, ~p"/admin/transformations/#{transformation}")

      assert html =~ "Show Transformation"
      assert html =~ transformation.description
    end

    test "updates transformation within modal", %{conn: conn, transformation: transformation} do
      {:ok, show_live, _html} = live(conn, ~p"/admin/transformations/#{transformation}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Transformation"

      assert_patch(show_live, ~p"/admin/transformations/#{transformation}/show/edit")

      assert show_live
             |> form("#transformation-form", transformation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#transformation-form", transformation: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/admin/transformations/#{transformation}")

      html = render(show_live)
      assert html =~ "Transformation updated successfully"
      assert html =~ "some updated description"
    end
  end
end
