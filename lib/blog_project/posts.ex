defmodule BlogProject.Posts do
  import Ecto.Query, warn: false
  alias BlogProject.Repo
  alias BlogProject.Posts.Post

  @doc """
  Fetches all posts.
  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Fetches a specific post by its public ID.
  """
  def get_post_by_public_id(public_id) do
    Repo.get_by(Post, public_id: public_id)
  end
end
