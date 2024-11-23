defmodule BlogProject.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlogProject.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        public_id: "7488a646-e31f-11e4-aace-600308960662",
        title: "some title"
      })
      |> BlogProject.Blog.create_post()

    post
  end
end
