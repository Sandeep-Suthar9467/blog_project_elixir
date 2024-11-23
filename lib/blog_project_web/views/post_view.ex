defmodule BlogProjectWeb.PostView do
  # Use :view for JSON rendering
  use BlogProjectWeb, :view

  @doc """
  Renders a list of posts as JSON.
  """
  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, __MODULE__, "post.json")}
  end

  @doc """
  Renders a single post as JSON.
  """
  def render("post.json", %{post: post}) do
    %{
      title: post.title,
      published: true,
      id: post.public_id,
      content: post.content,
      postedOn: post.posted_on,
      authorId: post.user_id,
      author: %{
        name: "name"
      }
    }
  end
end
