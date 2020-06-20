defmodule Bkmarkus.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    field :username, :string
    pow_user_fields()

    has_many :bookmarks, Bookmarkus.Bookmarks.Bookmark
    timestamps()
  end

  def changeset_username(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:username])
  end
  
  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> changeset_username(attrs)
  end
end
