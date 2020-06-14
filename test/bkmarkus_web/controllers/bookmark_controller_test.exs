defmodule BkmarkusWeb.BookmarkControllerTest do
  use BkmarkusWeb.ConnCase

  alias Bkmarkus.Bookmarks

  @create_attrs %{address: "some address", archive_page: true, archive_url: "some archive_url", description: "some description", hashed_url: "some hashed_url", is_archived: true, private: true, title: "some title"}
  @update_attrs %{address: "some updated address", archive_page: false, archive_url: "some updated archive_url", description: "some updated description", hashed_url: "some updated hashed_url", is_archived: false, private: false, title: "some updated title"}
  @invalid_attrs %{address: nil, archive_page: nil, archive_url: nil, description: nil, hashed_url: nil, is_archived: nil, private: nil, title: nil}

  def fixture(:bookmark) do
    {:ok, bookmark} = Bookmarks.create_bookmark(@create_attrs)
    bookmark
  end

  describe "index" do
    test "lists all bookmarks", %{conn: conn} do
      conn = get(conn, Routes.bookmark_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Bookmarks"
    end
  end

  describe "new bookmark" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.bookmark_path(conn, :new))
      assert html_response(conn, 200) =~ "New Bookmark"
    end
  end

  describe "create bookmark" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bookmark_path(conn, :create), bookmark: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.bookmark_path(conn, :show, id)

      conn = get(conn, Routes.bookmark_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Bookmark"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bookmark_path(conn, :create), bookmark: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Bookmark"
    end
  end

  describe "edit bookmark" do
    setup [:create_bookmark]

    test "renders form for editing chosen bookmark", %{conn: conn, bookmark: bookmark} do
      conn = get(conn, Routes.bookmark_path(conn, :edit, bookmark))
      assert html_response(conn, 200) =~ "Edit Bookmark"
    end
  end

  describe "update bookmark" do
    setup [:create_bookmark]

    test "redirects when data is valid", %{conn: conn, bookmark: bookmark} do
      conn = put(conn, Routes.bookmark_path(conn, :update, bookmark), bookmark: @update_attrs)
      assert redirected_to(conn) == Routes.bookmark_path(conn, :show, bookmark)

      conn = get(conn, Routes.bookmark_path(conn, :show, bookmark))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, bookmark: bookmark} do
      conn = put(conn, Routes.bookmark_path(conn, :update, bookmark), bookmark: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Bookmark"
    end
  end

  describe "delete bookmark" do
    setup [:create_bookmark]

    test "deletes chosen bookmark", %{conn: conn, bookmark: bookmark} do
      conn = delete(conn, Routes.bookmark_path(conn, :delete, bookmark))
      assert redirected_to(conn) == Routes.bookmark_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.bookmark_path(conn, :show, bookmark))
      end
    end
  end

  defp create_bookmark(_) do
    bookmark = fixture(:bookmark)
    %{bookmark: bookmark}
  end
end
