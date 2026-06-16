defmodule RohlikBackendWeb.LoginController do
  use RohlikBackendWeb, :controller

  alias RohlikBackend.{UserParams, Users}

  def access_token(conn, body) do
    case UserParams.normalize(body) do
      {:ok, attrs} ->
        if UserParams.registration?(attrs) do
          user = Users.register(attrs)
          conn |> put_status(:created) |> json(%{user: user})
        else
          login(conn, attrs)
        end

      :error ->
        conn |> put_status(:bad_request) |> json(%{error: "Invalid user payload"})
    end
  end

  defp login(conn, attrs) do
    case Users.find_by_credentials(attrs.email, attrs.password) do
      nil ->
        conn |> put_status(:unauthorized) |> json(%{error: "Invalid email or password"})

      user ->
        conn
        |> put_status(:created)
        |> json(%{
          access_token: "dummy-token",
          token_type: "bearer",
          user: %{id: user.id, email: user.email, name: user.name}
        })
    end
  end
end
