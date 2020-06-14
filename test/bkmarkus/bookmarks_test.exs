defmodule Bkmarkus.BookmarksTest do
  use Bkmarkus.DataCase

  alias Bkmarkus.Bookmarks

  describe "bookmarks" do
    alias Bkmarkus.Bookmarks.Bookmark

    @valid_attrs %{address: "some address", archive_page: true, archive_url: "some archive_url", description: "some description", hashed_url: "some hashed_url", is_archived: true, private: true, title: "some title"}
    @update_attrs %{address: "some updated address", archive_page: false, archive_url: "some updated archive_url", description: "some updated description", hashed_url: "some updated hashed_url", is_archived: false, private: false, title: "some updated title"}
    @invalid_attrs %{address: nil, archive_page: nil, archive_url: nil, description: nil, hashed_url: nil, is_archived: nil, private: nil, title: nil}

    def bookmark_fixture(attrs \\ %{}) do
      {:ok, bookmark} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bookmarks.create_bookmark()

      bookmark
    end

    test "list_bookmarks/0 returns all bookmarks" do
      bookmark = bookmark_fixture()
      assert Bookmarks.list_bookmarks() == [bookmark]
    end

    test "get_bookmark!/1 returns the bookmark with given id" do
      bookmark = bookmark_fixture()
      assert Bookmarks.get_bookmark!(bookmark.id) == bookmark
    end

    test "create_bookmark/1 with valid data creates a bookmark" do
      assert {:ok, %Bookmark{} = bookmark} = Bookmarks.create_bookmark(@valid_attrs)
      assert bookmark.address == "some address"
      assert bookmark.archive_page == true
      assert bookmark.archive_url == "some archive_url"
      assert bookmark.description == "some description"
      assert bookmark.hashed_url == "some hashed_url"
      assert bookmark.is_archived == true
      assert bookmark.private == true
      assert bookmark.title == "some title"
    end

    test "create_bookmark/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookmarks.create_bookmark(@invalid_attrs)
    end

    test "update_bookmark/2 with valid data updates the bookmark" do
      bookmark = bookmark_fixture()
      assert {:ok, %Bookmark{} = bookmark} = Bookmarks.update_bookmark(bookmark, @update_attrs)
      assert bookmark.address == "some updated address"
      assert bookmark.archive_page == false
      assert bookmark.archive_url == "some updated archive_url"
      assert bookmark.description == "some updated description"
      assert bookmark.hashed_url == "some updated hashed_url"
      assert bookmark.is_archived == false
      assert bookmark.private == false
      assert bookmark.title == "some updated title"
    end

    test "update_bookmark/2 with invalid data returns error changeset" do
      bookmark = bookmark_fixture()
      assert {:error, %Ecto.Changeset{}} = Bookmarks.update_bookmark(bookmark, @invalid_attrs)
      assert bookmark == Bookmarks.get_bookmark!(bookmark.id)
    end

    test "delete_bookmark/1 deletes the bookmark" do
      bookmark = bookmark_fixture()
      assert {:ok, %Bookmark{}} = Bookmarks.delete_bookmark(bookmark)
      assert_raise Ecto.NoResultsError, fn -> Bookmarks.get_bookmark!(bookmark.id) end
    end

    test "change_bookmark/1 returns a bookmark changeset" do
      bookmark = bookmark_fixture()
      assert %Ecto.Changeset{} = Bookmarks.change_bookmark(bookmark)
    end
  end
end
