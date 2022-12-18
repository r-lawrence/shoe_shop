defmodule ShoeShop.Shoes do
  @moduledoc """
  The Shoes context.
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
  def list_shoes do
    Repo.all(Shoe)
  end

  def get_type(:type, type) do
   query =
      from s in Shoe,
        where: s.type == ^type,
        select: s
    Repo.all(query)

  end

  @doc """
  Gets a single shoe.

  Raises `Ecto.NoResultsError` if the Shoe does not exist.

  ## Examples

      iex> get_shoe!(123)
      %Shoe{}

      iex> get_shoe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shoe!(id), do: Repo.get!(Shoe, id)

  @doc """
  Creates a shoe.

  ## Examples

      iex> create_shoe(%{field: value})
      {:ok, %Shoe{}}

      iex> create_shoe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shoe(attrs \\ %{}) do
    %Shoe{}
    |> Shoe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shoe.

  ## Examples

      iex> update_shoe(shoe, %{field: new_value})
      {:ok, %Shoe{}}

      iex> update_shoe(shoe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shoe(%Shoe{} = shoe, attrs) do
    shoe
    |> Shoe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shoe.

  ## Examples

      iex> delete_shoe(shoe)
      {:ok, %Shoe{}}

      iex> delete_shoe(shoe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shoe(%Shoe{} = shoe) do
    Repo.delete(shoe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shoe changes.

  ## Examples

      iex> change_shoe(shoe)
      %Ecto.Changeset{data: %Shoe{}}

  """
  def change_shoe(%Shoe{} = shoe, attrs \\ %{}) do
    Shoe.changeset(shoe, attrs)
  end
end
