defmodule BlogProject.Repo do
  use Ecto.Repo,
    otp_app: :blog_project,
    adapter: Ecto.Adapters.Postgres
end
