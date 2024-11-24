defmodule BlogProjectWeb.Utils.CORS do
  @moduledoc """
  Returns Allowed Origins
  """

  @doc """
  Returns regular expression to match for CORS.

  ## Examples
      iex> origins
      ~r/(^https:\/\/(.*\.|)idfystaging\.com$)/
  """
  @spec origins() :: Regex.t()
  def origins do
    ~r/#{System.get_env("CORS_ORIGIN")}/
  end
end
