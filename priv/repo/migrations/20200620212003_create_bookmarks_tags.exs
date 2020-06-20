defmodule Bkmarkus.Repo.Migrations.CreateBookmarksTags do
  use Ecto.Migration

  def change do
    create table(:bookmarks_tags) do
      add :bookmark_id, references(:bookmarks, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)
    end

    create index(:bookmarks_tags, [:bookmark_id])
    create index(:bookmarks_tags, [:tag_id])
  end
end
