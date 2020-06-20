defmodule Bkmarkus.Bookmarks.BookmarkTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookmarks_tags" do
    field :bookmark_id, :id
    field :tag_id, :id

    timestamps()
  end

  @doc false
  def changeset(bookmark_tag, attrs) do
    bookmark_tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
