defmodule Bkmarkus.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :username, :string

    has_many :bookmarks, Bookmarkus.Bookmarks.Bookmark
    timestamps()
  end
end
