defmodule RohlikBackend.UserParams do
  @moduledoc false

  def normalize(body) when is_map(body) do
    user = Map.get(body, "user", %{})

    case Map.get(user, "email") do
      email when is_binary(email) and email != "" ->
        {:ok,
         %{
           email: email,
           password: string_or_empty(Map.get(user, "password")),
           name: string_or_empty(Map.get(user, "name")),
           phone: string_or_empty(Map.get(user, "phone")),
           fb: Map.get(user, "fb")
         }}

      _ ->
        :error
    end
  end

  def normalize(_), do: :error

  def registration?(attrs) do
    fb = attrs.fb

    attrs.name != "" or attrs.phone != "" or
      (is_map(fb) and (present?(fb["uid"]) or present?(fb["token"])))
  end

  defp string_or_empty(value) when is_binary(value), do: value
  defp string_or_empty(_), do: ""

  defp present?(value) when is_binary(value), do: value != ""
  defp present?(value) when not is_nil(value), do: true
  defp present?(_), do: false
end
