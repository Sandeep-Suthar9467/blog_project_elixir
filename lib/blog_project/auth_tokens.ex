defmodule BlogProject.AuthTokens do
  @moduledoc """
  The AuthTokens context.
  """

  import Ecto.Query, warn: false
  alias BlogProject.Repo

  alias BlogProject.AuthTokens.AuthToken

  @doc """
  Returns the list of auth_tokens.

  ## Examples

      iex> list_auth_tokens()
      [%AuthToken{}, ...]

  """
  def list_auth_tokens do
    Repo.all(AuthToken)
  end

  @doc """
  Gets a single auth_token.

  Raises `Ecto.NoResultsError` if the Auth token does not exist.

  ## Examples

      iex> get_auth_token!(123)
      %AuthToken{}

      iex> get_auth_token!(456)
      ** (Ecto.NoResultsError)

  """
  def get_auth_token!(id), do: Repo.get!(AuthToken, id)

  def get_auth_token_by_token(token) do
    from(at in AuthToken, where: at.token == ^token)
    |> Repo.one()
  end

  @doc """
  Creates a auth_token.

  ## Examples

      iex> create_auth_token(%{field: value})
      {:ok, %AuthToken{}}

      iex> create_auth_token(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_auth_token(attrs \\ %{}) do
    %AuthToken{}
    |> AuthToken.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a auth_token.

  ## Examples

      iex> update_auth_token(auth_token, %{field: new_value})
      {:ok, %AuthToken{}}

      iex> update_auth_token(auth_token, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_auth_token(%AuthToken{} = auth_token, attrs) do
    auth_token
    |> AuthToken.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a auth_token.

  ## Examples

      iex> delete_auth_token(auth_token)
      {:ok, %AuthToken{}}

      iex> delete_auth_token(auth_token)
      {:error, %Ecto.Changeset{}}

  """
  def delete_auth_token(%AuthToken{} = auth_token) do
    Repo.delete(auth_token)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking auth_token changes.

  ## Examples

      iex> change_auth_token(auth_token)
      %Ecto.Changeset{data: %AuthToken{}}

  """
  def change_auth_token(%AuthToken{} = auth_token, attrs \\ %{}) do
    AuthToken.changeset(auth_token, attrs)
  end
end
