defmodule BlogProject.Users do
  import Ecto.Query, warn: false
  alias BlogProject.Repo
  alias BlogProject.Users.User

  @doc """
  Fetches all users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Fetches a specific user by their email.
  """
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  @doc """
  Fetches a specific user by their ID.
  """
  def get_user_by_id(id) do
    Repo.get(User, id)
  end

  @doc """
  Creates a new user.
  """
  def create_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def get_user_by_username(name) do
    Repo.get_by(User, name: name)
    # from(
    #   u in User,
    #   where: u.name == ^username,
    #   select: [:id, :inserted_at, :updated_at]
    # )
    # |> Repo.one()
  end
end
