defmodule RohlikBackend.Catalog do
  @moduledoc false

  def categories do
    priv_path("data/categories.json")
    |> File.read!()
    |> Jason.decode!()
  end

  def products do
    priv_path("data/products.json")
    |> File.read!()
    |> Jason.decode!()
    |> Enum.map(&with_image_url/1)
  end

  defp priv_path(relative) do
    Path.join(:code.priv_dir(:rohlik_backend), relative)
  end

  defp with_image_url(product) do
    Map.put(product, "image", product_image_url(product))
  end

  defp product_image_url(%{"image" => path, "id" => id}) when is_binary(path) do
    cond do
      String.starts_with?(path, "http://") -> path
      String.starts_with?(path, "https://") -> path
      true -> "https://picsum.photos/seed/#{id}/300/300"
    end
  end

  defp product_image_url(%{"id" => id}), do: "https://picsum.photos/seed/#{id}/300/300"
end
