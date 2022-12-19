defmodule ShoeShop.ShoesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ShoeShop.Shoes` context.
  """

  alias ShoeShop.Repo
  alias ShoeShop.Shoes.Shoe
  @doc """
  Generate a shoe.
  """
  def insert_shoe(attrs \\ %{}) do
    {:ok, shoe} =
      %Shoe{}
        |> Shoe.changeset(attrs)
        |> Repo.insert()
    shoe
  end

  def insert_multiple_shoes(shoes \\ []) do
    inserted_shoes = Enum.map(shoes, fn shoe ->
      {:ok, new_shoe} =
        %Shoe{}
        |> Shoe.changeset(shoe)
        |> Repo.insert()

      new_shoe
    end)

    inserted_shoes
  end
end
