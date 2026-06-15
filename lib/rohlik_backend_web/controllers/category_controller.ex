defmodule RohlikBackendWeb.CategoryController do
  use RohlikBackendWeb, :controller

  alias RohlikBackend.Catalog

  def index(conn, _params) do
    json(conn, %{categories: Catalog.categories()})
  end
end
