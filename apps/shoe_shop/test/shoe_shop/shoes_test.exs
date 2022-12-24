defmodule ShoeShop.ShoesTest do
  use ShoeShop.DataCase
  import ShoeShop.ShoesFixtures
  alias ShoeShop.Shoes

  alias ShoeShop.Repo

  describe "shoes" do
    test "list_shoes/0 returns all shoes" do
      shoe =
        insert_shoe(%{
          id: Ecto.UUID.generate(),
          img_url: "/temp-1.png",
          type: "Men",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Basic"
        })

      assert Shoes.list_shoes() == [shoe]
    end

    test "get_type/2 when type is set to men, returns only mens shoes" do
      handle_multi_insert_setup()
      all_shoes = Shoes.list_shoes()
      mens_shoes = Shoes.get_type(:type, "Men")

      assert length(all_shoes) > length(mens_shoes)

      Enum.each(mens_shoes, fn shoe ->
        assert shoe.type == "Men"
      end)
    end

    test "get_type/2 when type is set to women, returns only womens shoes" do
      handle_multi_insert_setup()
      all_shoes = Shoes.list_shoes()
      mens_shoes = Shoes.get_type(:type, "Women")

      assert length(all_shoes) > length(mens_shoes)

      Enum.each(mens_shoes, fn shoe ->
        assert shoe.type == "Women"
      end)
    end
  end

  defp handle_multi_insert_setup do
    shoes =
      insert_multiple_shoes([
        %{
          id: Ecto.UUID.generate(),
          img_url: "/temp-1.png",
          type: "Men",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Basic"
        },
        %{
          id: Ecto.UUID.generate(),
          img_url: "/temp-2.png",
          type: "Men",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Enhanced"
        },
        %{
          id: Ecto.UUID.generate(),
          img_url: "/temp-3.png",
          type: "Men",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Pro"
        },
        %{
          id: Ecto.UUID.generate(),
          img_url: "/temp-1.png",
          type: "Women",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Basic"
        },
        %{
          id: Ecto.UUID.generate(),
          img_url: "/temp-1.png",
          type: "Women",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Enhanced"
        },
        %{
          id: Ecto.UUID.generate(),
          img_url: "/temp-1.png",
          type: "Women",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Pro"
        }
      ])

    shoes
  end
end
