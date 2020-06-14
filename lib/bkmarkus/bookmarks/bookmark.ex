defmodule Bkmarkus.Bookmarks.Bookmark do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookmarks" do
    field :address, :string
    field :archive_page, :boolean, default: false
    field :archive_url, :string
    field :description, :string
    field :hashed_url, :string
    field :is_archived, :boolean, default: false
    field :private, :boolean, default: false
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(bookmark, attrs) do
    bookmark
    |> cast(attrs, [:title, :address, :private, :archive_page, :description, :hashed_url, :is_archived, :archive_url])
    |> validate_required([:title, :address, :private, :archive_page])
  end
end
