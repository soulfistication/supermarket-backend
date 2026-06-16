defmodule RohlikBackendWeb.ProductController do
  use RohlikBackendWeb, :controller

  alias RohlikBackend.Catalog

  def index(conn, _params) do
    json(conn, %{products: Catalog.products()})
  end
end
