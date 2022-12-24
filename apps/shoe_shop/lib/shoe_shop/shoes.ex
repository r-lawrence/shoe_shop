defmodule ShoeShop.Shoes do
  @moduledoc """
    The Shoes context.  Provides different functionality to retrieve shoe inventory,
    for display on shoe_shop_web.
  """
  import Ecto.Query, warn: false
  alias ShoeShop.Repo
  alias ShoeShop.Shoes.Shoe

  @doc """
  Returns the list of shoes.

  ## Examples

      iex> list_shoes()
      [%Shoe{}, ...]

  """
  @spec list_shoes :: list(Shoe.t()) | nil
  def list_shoes do
    Repo.all(Shoe)
  end

  @doc """
  returns a list of shoes based on a specific type

  ## Examples

      iex> get_type(:type, "exercise")
      [%Shoe{}, ...]

  """
  @spec get_type(atom(), String.t()) :: list(Shoe.t()) | nil
  def get_type(:type, type) do
    query =
      from s in Shoe,
        where: s.type == ^type,
        select: s

    Repo.all(query)
  end
end
