# defmodule BlogProjectWeb.PostControllerTest do
#   use BlogProjectWeb.ConnCase

#   import BlogProject.BlogFixtures

#   @create_attrs %{content: "some content", public_id: "7488a646-e31f-11e4-aace-600308960662", title: "some title"}
#   @update_attrs %{content: "some updated content", public_id: "7488a646-e31f-11e4-aace-600308960668", title: "some updated title"}
#   @invalid_attrs %{content: nil, public_id: nil, title: nil}

#   describe "index" do
#     test "lists all posts", %{conn: conn} do
#       conn = get(conn, ~p"/posts")
#       assert html_response(conn, 200) =~ "Listing Posts"
#     end
#   end

#   describe "new post" do
#     test "renders form", %{conn: conn} do
#       conn = get(conn, ~p"/posts/new")
#       assert html_response(conn, 200) =~ "New Post"
#     end
#   end

#   describe "create post" do
#     test "redirects to show when data is valid", %{conn: conn} do
#       conn = post(conn, ~p"/posts", post: @create_attrs)

#       assert %{id: id} = redirected_params(conn)
#       assert redirected_to(conn) == ~p"/posts/#{id}"

#       conn = get(conn, ~p"/posts/#{id}")
#       assert html_response(conn, 200) =~ "Post #{id}"
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post(conn, ~p"/posts", post: @invalid_attrs)
#       assert html_response(conn, 200) =~ "New Post"
#     end
#   end

#   describe "edit post" do
#     setup [:create_post]

#     test "renders form for editing chosen post", %{conn: conn, post: post} do
#       conn = get(conn, ~p"/posts/#{post}/edit")
#       assert html_response(conn, 200) =~ "Edit Post"
#     end
#   end

#   describe "update post" do
#     setup [:create_post]

#     test "redirects when data is valid", %{conn: conn, post: post} do
#       conn = put(conn, ~p"/posts/#{post}", post: @update_attrs)
#       assert redirected_to(conn) == ~p"/posts/#{post}"

#       conn = get(conn, ~p"/posts/#{post}")
#       assert html_response(conn, 200) =~ "some updated content"
#     end

#     test "renders errors when data is invalid", %{conn: conn, post: post} do
#       conn = put(conn, ~p"/posts/#{post}", post: @invalid_attrs)
#       assert html_response(conn, 200) =~ "Edit Post"
#     end
#   end

#   describe "delete post" do
#     setup [:create_post]

#     test "deletes chosen post", %{conn: conn, post: post} do
#       conn = delete(conn, ~p"/posts/#{post}")
#       assert redirected_to(conn) == ~p"/posts"

#       assert_error_sent 404, fn ->
#         get(conn, ~p"/posts/#{post}")
#       end
#     end
#   end

#   defp create_post(_) do
#     post = post_fixture()
#     %{post: post}
#   end
# end
