defmodule ShoeShopWeb.PageViewTest do
  use ShoeShopWeb.ConnCase, async: true
  import ShoeShop.ShoesFixtures
  alias ShoeShopWeb.PageView

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(ShoeShop.Repo)
    [shoes: insert_shoes()]
  end

  describe "render_summary/1" do
    test "when cart is empty, summary values are 0" do
      assigns = %{
        cart: []
      }

      html =
        PageView.render_summary(assigns)
        |> Phoenix.HTML.Safe.to_iodata()
        |> Floki.parse_document!()

      rendered_subtotal =
        html
        |> Floki.find("label.subtotal")
        |> Floki.text()

      rendered_shipping =
        html
        |> Floki.find("label.shipping")
        |> Floki.text()

      rendered_tax =
        html
        |> Floki.find("label.tax")
        |> Floki.text()

      rendered_total =
        html
        |> Floki.find("label.total")
        |> Floki.text()

      assert rendered_subtotal =~ "$0.00"
      assert rendered_shipping =~ "$0.00"
      assert rendered_tax =~ "$0.00"
      assert rendered_total =~ "$0.00"
    end

    test "when cart contains a shoe, summary values are calculated", %{shoes: shoes} do
      shoe = create_cart_value(Enum.at(shoes, 0), "7.0")

      assigns = %{
        cart: [shoe]
      }

      [price: price, shipping: shipping, tax: tax, total: total] = calculate_values([shoe])

      html =
        PageView.render_summary(assigns)
        |> Phoenix.HTML.Safe.to_iodata()
        |> Floki.parse_document!()

      rendered_subtotal =
        html
        |> Floki.find("label.subtotal")
        |> Floki.text()

      rendered_shipping =
        html
        |> Floki.find("label.shipping")
        |> Floki.text()

      rendered_tax =
        html
        |> Floki.find("label.tax")
        |> Floki.text()

      rendered_total =
        html
        |> Floki.find("label.total")
        |> Floki.text()

      assert rendered_subtotal =~ price
      assert rendered_shipping =~ shipping
      assert rendered_tax =~ tax
      assert rendered_total =~ total
    end

    test "when multiple shoes are in cart, summary values are calculated correctly", %{
      shoes: shoes
    } do
      shoe = create_cart_value(Enum.at(shoes, 0), "7.0")
      shoe_2 = create_cart_value(Enum.at(shoes, 2), "8.0")

      assigns = %{
        cart: [shoe, shoe_2]
      }

      html =
        PageView.render_summary(assigns)
        |> Phoenix.HTML.Safe.to_iodata()
        |> Floki.parse_document!()

      [price: price, shipping: shipping, tax: tax, total: total] =
        calculate_values([shoe, shoe_2])

      html =
        PageView.render_summary(assigns)
        |> Phoenix.HTML.Safe.to_iodata()
        |> Floki.parse_document!()

      rendered_subtotal =
        html
        |> Floki.find("label.subtotal")
        |> Floki.text()

      rendered_shipping =
        html
        |> Floki.find("label.shipping")
        |> Floki.text()

      rendered_tax =
        html
        |> Floki.find("label.tax")
        |> Floki.text()

      rendered_total =
        html
        |> Floki.find("label.total")
        |> Floki.text()

      assert rendered_subtotal =~ price
      assert rendered_shipping =~ shipping
      assert rendered_tax =~ tax
      assert rendered_total =~ total
    end
  end

  defp calculate_values(shoes) do
    prices =
      Enum.map(shoes, fn shoe ->
        shoe.price
      end)

    price = Enum.sum(prices)
    tax = (price * 0.0635) |> Float.floor(2)
    shipping = 8.00

    [
      price: to_string(price),
      shipping: to_string(shipping),
      tax: to_string(tax),
      total: to_string((price + tax + shipping) |> Float.floor(2))
    ]
  end

  defp create_cart_value(shoe, size) do
    %{
      id: shoe.id,
      img_url: shoe.img_url,
      size: size,
      price: shoe.price,
      style: shoe.style,
      type: shoe.type,
      name: shoe.name
    }
  end

  defp insert_shoes do
    shoes =
      insert_multiple_shoes([
        %{
          id: Ecto.UUID.generate(),
          img_url: "/men-temp-1.png",
          type: "Men",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Basic"
        },
        %{
          id: Ecto.UUID.generate(),
          img_url: "/men-temp-2.png",
          type: "Men",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Enhanced"
        },
        %{
          id: Ecto.UUID.generate(),
          img_url: "/men-temp-3.png",
          type: "Men",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Pro"
        },
        %{
          id: Ecto.UUID.generate(),
          img_url: "/women-temp-1.png",
          type: "Women",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Basic"
        },
        %{
          id: Ecto.UUID.generate(),
          img_url: "/women-temp-2.png",
          type: "Women",
          style: "exercise",
          price: 100,
          sizes: [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0],
          name: "Enhanced"
        },
        %{
          id: Ecto.UUID.generate(),
          img_url: "/women-temp-3.png",
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
