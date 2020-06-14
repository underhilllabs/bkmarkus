defmodule Bkmarkus.Repo.Migrations.CreateBookmarks do
  use Ecto.Migration

  def change do
    create table(:bookmarks) do
      add :title, :string
      add :address, :string
      add :private, :boolean, default: false, null: false
      add :archive_page, :boolean, default: false, null: false
      add :description, :text
      add :hashed_url, :string
      add :is_archived, :boolean, default: false, null: false
      add :archive_url, :string

      timestamps()
    end

  end
end
