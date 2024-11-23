defmodule BlogProject.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :public_id, Ecto.UUID
    field :content, :string
    field :posted_on, :utc_datetime
    belongs_to :user, BlogProject.Blog.User

    timestamps()
  end

  @doc """
  Creates a changeset for creating or updating a post.
  """
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :public_id, :content, :posted_on, :user_id])
    |> validate_required([:title, :content])
    |> foreign_key_constraint(:user_id)
  end
end
