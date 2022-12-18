defmodule ShoeShop.ShoesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ShoeShop.Shoes` context.
  """

  @doc """
  Generate a shoe.
  """
  def shoe_fixture(attrs \\ %{}) do
    {:ok, shoe} =
      attrs
      |> Enum.into(%{

      })
      |> ShoeShop.Shoes.create_shoe()

    shoe
  end
end
