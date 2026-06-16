defmodule RohlikBackendWeb.UserController do
  use RohlikBackendWeb, :controller

  alias RohlikBackend.{UserParams, Users}

  def create(conn, body) do
    case UserParams.normalize(body) do
      {:ok, attrs} ->
        user = Users.register(attrs)
        conn |> put_status(:created) |> json(%{user: user})

      :error ->
        conn |> put_status(:bad_request) |> json(%{error: "Invalid user payload"})
    end
  end
end
