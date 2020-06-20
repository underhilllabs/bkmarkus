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
    belongs_to :user, Bkmarkus.Users.User
    many_to_many :tags, Bkmarkus.Bookmarks.Tag, 
      join_through: "bookmarks_tags",
      on_replace: :delete

    timestamps()
  end

  @doc """
  Builds a changeset based on the bookmark struct and `params`.
  """
  def changeset(bookmark, attrs) do
    bookmark
    |> cast(attrs, [:title, :address, :private, :archive_page, :description, :hashed_url, :is_archived, :archive_url, :user_id])
    |> validate_required([:title, :address, :user_id])
    |> Ecto.Changeset.put_assoc(:tags, parse_tags(attrs))
  end

  defp parse_tags(params)  do
    (params["tags"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(& &1 == "")
    |> Enum.map(&get_or_insert_tag/1)
  end

  defp get_or_insert_tag(name) do
    Bkmarkus.Repo.get_by(Bkmarkus.Bookmarks.Tag, name: name) ||
      Bkmarkus.Repo.insert!(%Bkmarkus.Bookmarks.Tag{name: name})
  end
end
