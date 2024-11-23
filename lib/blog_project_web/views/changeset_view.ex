defmodule BlogProjectWeb.ChangesetView do
  use BlogProjectWeb, :view

  @doc """
  Traverses and translates changeset errors.

  See `Ecto.Changeset.traverse_errors/2` and
  `BlogProjectWeb.ErrorHelpers.translate_error/1` for more details.
  """
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{
      error: "unprocessable_entity",
      detail: translate_errors(changeset),
      message: "INVALID_REQUEST_BODY"
    }
  end
end
