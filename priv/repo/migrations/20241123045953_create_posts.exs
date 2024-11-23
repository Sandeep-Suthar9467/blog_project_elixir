defmodule BlogProject.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :public_id, :uuid, null: false
      add :content, :text
      add :posted_on, :utc_datetime
      add :user_id, references(:users, on_delete: :nilify_all), null: true

      timestamps()
    end

    create index(:posts, [:user_id])
  end
end
