defmodule BlogProjectWeb.PostController do
  use BlogProjectWeb, :controller

  alias BlogProject.Blog
  alias BlogProject.Blog.Post
  action_fallback(BlogProjectWeb.FallbackController)

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.json", posts: posts)
  end

  # def new(conn, _params) do
  #   changeset = Blog.change_post(%Post{})
  #   render(conn, :new, changeset: changeset)
  # end

  def create(conn, %{"post" => post_params}) do
    user = Map.get(conn.assigns, :current_user)
    post_params = mixed_maps_to_atom(Map.merge(post_params, %{
      user_id: user.id,
      posted_on: DateTime.utc_now(),
      public_id: UUID.uuid4()
    }))
    IO.inspect(post_params)
    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_status(:ok)
        |> render("post.json", post: post)

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post_by_public_id(id)
    render(conn, "post.json", post: post)
  end

  def show_user_blog(conn, params) do
    user = Map.get(conn.assigns, :current_user)
    posts = Blog.get_post_by_user_id(user.id)
    render(conn, "user_post.json", posts: posts || [], user: user)
  end

  # def edit(conn, %{"id" => id}) do
  #   post = Blog.get_post!(id)
  #   changeset = Blog.change_post(post)
  #   render(conn, :edit, post: post, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "post" => post_params}) do
  #   post = Blog.get_post!(id)

  #   case Blog.update_post(post, post_params) do
  #     {:ok, post} ->
  #       conn
  #       |> put_flash(:info, "Post updated successfully.")
  #       |> redirect(to: ~p"/posts/#{post}")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :edit, post: post, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   post = Blog.get_post!(id)
  #   {:ok, _post} = Blog.delete_post(post)

  #   conn
  #   |> put_flash(:info, "Post deleted successfully.")
  #   |> redirect(to: ~p"/posts")
  # end


  def mixed_maps_to_atom(map) do
    Enum.reduce(map, %{}, fn
      {key, value}, acc when is_atom(key) -> Map.put(acc, key, value)
      # String.to_existing_atom saves us from overloading the VM by
      # creating too many atoms. It'll always succeed because all the fields
      # in the database already exist as atoms at runtime.
      {key, value}, acc when is_binary(key) -> Map.put(acc, :"#{key}", value)
    end)
  end
end
