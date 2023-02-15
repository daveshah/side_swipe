defmodule SideSwipeWeb.TransformationControllerTest do
  use SideSwipeWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "POST /api/transformations" do
    test "renders a transformation", %{conn: conn} do
      conn = post(conn, ~p"/api/transformations", %{})
      assert %{} = json_response(conn, 200)["data"]
    end
  end
end
