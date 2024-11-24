defmodule BlogProject.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias BlogProject.AuthTokens.AuthToken

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Creates a changeset for user registration.
  """
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password_hash])
    |> validate_required([:email, :password_hash])
    |> validate_length(:name, min: 2, max: 20)
    |> validate_length(:password_hash, min: 8, max: 30)
    |> unique_constraint(:email)
    |> update_change(:email, fn email -> String.downcase(email) end)
    |> update_change(:name, &String.downcase(&1))
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password_hash: password_hash}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(password_hash))

      _ ->
        changeset
    end
  end

  @doc """
  Creates a changeset for updating user information.
  """
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
