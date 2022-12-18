defmodule ShoeShop.ShoesTest do
  use ShoeShop.DataCase

  alias ShoeShop.Shoes

  describe "shoes" do
    alias ShoeShop.Shoes.Shoe

    import ShoeShop.ShoesFixtures

    @invalid_attrs %{}

    test "list_shoes/0 returns all shoes" do
      shoe = shoe_fixture()
      assert Shoes.list_shoes() == [shoe]
    end

    test "get_shoe!/1 returns the shoe with given id" do
      shoe = shoe_fixture()
      assert Shoes.get_shoe!(shoe.id) == shoe
    end

    test "create_shoe/1 with valid data creates a shoe" do
      valid_attrs = %{}

      assert {:ok, %Shoe{} = shoe} = Shoes.create_shoe(valid_attrs)
    end

    test "create_shoe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shoes.create_shoe(@invalid_attrs)
    end

    test "update_shoe/2 with valid data updates the shoe" do
      shoe = shoe_fixture()
      update_attrs = %{}

      assert {:ok, %Shoe{} = shoe} = Shoes.update_shoe(shoe, update_attrs)
    end

    test "update_shoe/2 with invalid data returns error changeset" do
      shoe = shoe_fixture()
      assert {:error, %Ecto.Changeset{}} = Shoes.update_shoe(shoe, @invalid_attrs)
      assert shoe == Shoes.get_shoe!(shoe.id)
    end

    test "delete_shoe/1 deletes the shoe" do
      shoe = shoe_fixture()
      assert {:ok, %Shoe{}} = Shoes.delete_shoe(shoe)
      assert_raise Ecto.NoResultsError, fn -> Shoes.get_shoe!(shoe.id) end
    end

    test "change_shoe/1 returns a shoe changeset" do
      shoe = shoe_fixture()
      assert %Ecto.Changeset{} = Shoes.change_shoe(shoe)
    end
  end
end
