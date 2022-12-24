defmodule ShoeShopWeb.LiveShoeShopTest do
  use ExUnit.Case, async: true
  import Phoenix.ConnTest
  import ShoeShop.ShoesFixtures
  import Phoenix.LiveViewTest

  @endpoint ShoeShopWeb.Endpoint

  alias ShoeShopWeb.LiveShoeShop

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(ShoeShop.Repo)
  end

  describe "mount/3" do
    setup do
      handle_multi_insert_setup()
      [socket: %Phoenix.LiveView.Socket{}]
    end

    test "on mount, assigns the correct defualt values to socket", %{socket: socket} do
      {:ok,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       }} = LiveShoeShop.mount(%{}, %{}, socket)

      assert [] == assigns.cart
      assert nil == assigns.preview
      assert "Men" == assigns.shoe_selection
      assert 3 == length(assigns.shoes)
      assert false == assigns.show_checkout
    end
  end

  describe "handle_event/3" do
    setup do
      handle_multi_insert_setup()
      [socket: %Phoenix.LiveView.Socket{}]
    end

    test "changeShoeTypeSelection event: when selected type is men and change type is women, updates assigns and returns socket",
         %{socket: socket} do
      {:ok,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       } = socket} = LiveShoeShop.mount(%{}, %{}, socket)

      assert "Men" == assigns.shoe_selection

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns_2
       } = _socket} =
        LiveShoeShop.handle_event("changeShoeTypeSelection", %{"value" => "Women"}, socket)

      assert assigns_2.shoes != assigns.shoes
      assert "Women" == assigns_2.shoe_selection
    end

    test "changeShoeTypeSelection event: when selected type is women and change type is men, updates assigns and returns socket",
         %{socket: socket} do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       } = socket} =
        LiveShoeShop.handle_event("changeShoeTypeSelection", %{"value" => "Women"}, socket)

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns_2
       } = _socket} =
        LiveShoeShop.handle_event("changeShoeTypeSelection", %{"value" => "Men"}, socket)

      assert assigns_2.shoes != assigns.shoes
      assert "Men" == assigns_2.shoe_selection
    end

    test "changeShoeTypeSelection event: when selected type matches the change type, returns socket only",
         %{socket: socket} do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)

      {:noreply, socket_2} =
        LiveShoeShop.handle_event("changeShoeTypeSelection", %{"value" => "Men"}, socket)

      assert socket.assigns == socket_2.assigns
    end

    test "renderShoePreview event: when a shoe id is provided, updates assigns and returns socket",
         %{socket: socket} do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)

      shoe = Enum.at(socket.assigns.shoes, 0)

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       } = _socket} =
        LiveShoeShop.handle_event("renderShoePreview", %{"shoe_id" => shoe.id}, socket)

      assert assigns.preview == shoe
    end

    test "addToCart event: when id and size are provided, updates assigns and returns socket", %{
      socket: socket
    } do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)
      shoe = Enum.at(socket.assigns.shoes, 0)

      assert [] == socket.assigns.cart

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       } = _socket} =
        LiveShoeShop.handle_event(
          "addToCart",
          %{"id" => "add-to-cart-shoe-id-#{shoe.id}", "size" => 7},
          socket
        )

      assert [
               %{
                 id: shoe.id,
                 img_url: "/men-temp-1.png",
                 name: "Basic",
                 price: 100,
                 size: 7,
                 style: "exercise",
                 type: "Men"
               }
             ] == assigns.cart
    end

    test "addToCart event: when a cart exists and size/id are provided, updates assigns and returns socket",
         %{socket: socket} do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)
      shoe = Enum.at(socket.assigns.shoes, 0)
      shoe_2 = Enum.at(socket.assigns.shoes, 1)

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       } = socket} =
        LiveShoeShop.handle_event(
          "addToCart",
          %{"id" => "add-to-cart-shoe-id-#{shoe.id}", "size" => 7},
          socket
        )

      assert 1 == length(assigns.cart)

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns_2
       } = _socket} =
        LiveShoeShop.handle_event(
          "addToCart",
          %{"id" => "add-to-cart-shoe-id-#{shoe_2.id}", "size" => 6},
          socket
        )

      assert [
               %{
                 id: shoe.id,
                 img_url: shoe.img_url,
                 name: shoe.name,
                 price: shoe.price,
                 size: 7,
                 style: shoe.style,
                 type: shoe.type
               },
               %{
                 id: shoe_2.id,
                 img_url: shoe_2.img_url,
                 name: shoe_2.name,
                 price: shoe_2.price,
                 size: 6,
                 style: shoe_2.style,
                 type: shoe_2.type
               }
             ] == assigns_2.cart
    end

    test "removeCartItem event: when id is provided, removes correct id from cart, updates assigns, and returns socket",
         %{socket: socket} do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)
      shoe = Enum.at(socket.assigns.shoes, 0)

      {:noreply, socket} =
        LiveShoeShop.handle_event(
          "addToCart",
          %{"id" => "add-to-cart-shoe-id-#{shoe.id}", "size" => 7},
          socket
        )

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       } = _socket} = LiveShoeShop.handle_event("removeCartItem", %{"id" => shoe.id}, socket)

      assert [] == assigns.cart
    end

    test "removeCartItem event: when id is provided and multiple items exist in cart, removes correct id from cart, updates assigns, and returns socket",
         %{socket: socket} do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)
      shoe = Enum.at(socket.assigns.shoes, 0)
      shoe_2 = Enum.at(socket.assigns.shoes, 1)

      {:noreply, socket} =
        LiveShoeShop.handle_event(
          "addToCart",
          %{"id" => "add-to-cart-shoe-id-#{shoe.id}", "size" => 7},
          socket
        )

      {:noreply, socket} =
        LiveShoeShop.handle_event(
          "addToCart",
          %{"id" => "add-to-cart-shoe-id-#{shoe_2.id}", "size" => 6},
          socket
        )

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       } = _socket} = LiveShoeShop.handle_event("removeCartItem", %{"id" => shoe.id}, socket)

      [
        %{
          id: shoe_2.id,
          img_url: shoe_2.img_url,
          name: shoe_2.name,
          price: shoe_2.price,
          size: 6,
          style: shoe_2.style,
          type: shoe_2.type
        }
      ] == assigns.cart
    end

    test "showCheckoutModal event: updates assigns and returns socket", %{socket: socket} do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)

      assert false == socket.assigns.show_checkout

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       } = _socket} = LiveShoeShop.handle_event("showCheckoutModal", %{}, socket)

      assert true == assigns.show_checkout
    end

    test "closeModal event: given a modal value of preview, updates assigns and returns socket",
         %{socket: socket} do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)
      shoe = Enum.at(socket.assigns.shoes, 0)

      {:noreply, socket} =
        LiveShoeShop.handle_event("renderShoePreview", %{"shoe_id" => shoe.id}, socket)

      assert nil != socket.assigns.preview

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       } = _socket} = LiveShoeShop.handle_event("closeModal", %{"modal" => "preview"}, socket)

      assert nil == assigns.preview
    end

    test "closeModal event: given a modal value of checkout, updates assigns and returns socket",
         %{socket: socket} do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)
      {:noreply, socket} = LiveShoeShop.handle_event("showCheckoutModal", %{}, socket)

      assert true == socket.assigns.show_checkout

      {:noreply,
       %Phoenix.LiveView.Socket{
         assigns: assigns
       } = _socket} = LiveShoeShop.handle_event("closeModal", %{"modal" => "checkout"}, socket)

      assert false == assigns.show_checkout
    end

    test "closeModal event: given any other modal value, just returns socket", %{socket: socket} do
      {:ok, socket} = LiveShoeShop.mount(%{}, %{}, socket)
      {:noreply, socket} = LiveShoeShop.handle_event("showCheckoutModal", %{}, socket)

      {:noreply, socket_2} =
        LiveShoeShop.handle_event("closeModal", %{"modal" => "a-value"}, socket)

      assert socket == socket_2
    end
  end

  # setup do
  #   :ok = Ecto.Adapters.SQL.Sandbox.checkout(ShoeShop.Repo)
  #   [shoes: handle_multi_insert_setup()]

  # end

  # describe "mount/3" do

  #   setup do
  #     # conn =
  #     # :ok
  #     [conn: build_conn()]
  #   end

  #   test "on mount, returns the home page and assigns default values", %{conn: conn} do
  #      %Plug.Conn{
  #       assigns: %{
  #         shoes: shoes,
  #         cart: cart,
  #         shoe_selection: selection,
  #         preview: preview,
  #         show_checkout: show_checkout
  #       }

  #       } = conn = get(conn, "/")

  #     {:ok, view, html} = live(conn)

  #     assert view.module == ShoeShopWeb.LiveShoeShop
  #     assert length(shoes) > 0
  #     assert [] == cart
  #     assert "Men" == selection
  #     assert nil == preview
  #     assert false == show_checkout
  #   end

  #   test "on mount, renders page title, type filter, style filter, container for each shoe", %{conn: conn} do
  #     conn = get(conn, "/")
  #     {:ok, _view, html} = live(conn)

  #     html =
  #       Floki.parse_document!(html)

  #     title =
  #       html
  #       |> Floki.find("header")
  #       |> Floki.text()

  #     type_filter =
  #       html
  #       |> Floki.find("select#type-selection")

  #     style_filter =
  #       html
  #       |> Floki.find("div.sidebar")

  #     shoe_containers =
  #       html
  #       |> Floki.find("div.shoe")

  #     assert title =~ "ShoeShop"
  #     assert [] != type_filter
  #     assert [] != style_filter
  #     assert 3 == length(shoe_containers)
  #   end

  #   test "on mount, the shoe cart should not be present", %{conn: conn} do
  #     conn = get(conn, "/")
  #     {:ok, _view, html} = live(conn)

  #     shoe_cart =
  #       html
  #       |> Floki.parse_document!()
  #       |> Floki.find("div.shoe-cart")
  #     assert [] == shoe_cart
  #   end
  # end

  # describe "handle_event/3" do
  #   setup do
  #     # conn =
  #     # :ok
  #     [conn: get(build_conn(), "/")]
  #   end

  #   test "changeShoeTypeSelection event: when a new style is selected, renders new shoes display", %{conn: conn} do

  #     {:ok, view, _html} = live(conn)
  #     html =
  #       view
  #       |> element("select#type-selection")
  #       |> render_hook("changeShoeTypeSelection", %{value: "Women"})
  #       |> Floki.parse_document!()

  #     shoes =
  #       html
  #       |> Floki.find("div.shoe")
  #       |> Floki.find("img")
  #       |> Floki.attribute("src")
  #       |> Floki.text()

  #      assert "/women-temp-1.png/women-temp-2.png/women-temp-3.png" == shoes
  #   end

  #   test "renderShoePreview event: renders shoe preview modal", %{conn: conn} do
  #     shoe = Enum.at(conn.assigns.shoes, 0)
  #     {:ok, view, html} = live(conn)
  #     html =
  #       view
  #       |> element(".shoe-#{shoe.id}")
  #       |> render_click()
  #       |> Floki.parse_document!()
  #       |> Floki.find("div.preview-shoe-modal")

  #     image_url =
  #       html
  #       |> Floki.find("img")
  #       |> Floki.attribute("src")
  #       |> Floki.text()

  #     details =
  #       html
  #       |> Floki.find("span")
  #       |> Floki.text()

  #     sizes =
  #       html
  #       |> Floki.find("option")
  #       |> Floki.text()

  #     add_to_cart_btn =
  #       html
  #       |> Floki.find("button")
  #       |> Floki.text()

  #     assert shoe.img_url == image_url
  #     assert details =~ shoe.name
  #     assert details =~ shoe.style
  #     assert details =~ to_string(shoe.price)

  #     Enum.each(shoe.sizes, fn size ->
  #       assert sizes =~ to_string(size)
  #     end)

  #     assert "add to cart" == add_to_cart_btn
  #   end

  #   test "addToCart event: when size and shoe id is provided, shows cart display", %{conn: conn} do
  #     shoe = Enum.at(conn.assigns.shoes, 0)

  #     {:ok, view, html} = live(conn)

  #     cart =
  #       html
  #       |> Floki.parse_document!()
  #       |> Floki.find("div.shoe-cart")

  #     assert [] == cart

  #     html = render_click(view, "addToCart", %{"id" => shoe.id, "size" => 7})
  #     cart =
  #       html
  #       |> Floki.parse_document!()
  #       |> Floki.find("div.shoe-cart")
  #       |> Floki.find("span")
  #       |> Floki.text()

  #     assert cart =~ "items in cart: 1"
  #   end

  #   test "addToCart event: when cart exists, updates cart with new item", %{conn: conn} do
  #     existing_shoe = Enum.at(conn.assigns.shoes, 0)
  #     shoe = Enum.at(conn.assigns.shoes, 1)

  #     new_assigns =
  #       conn.assigns
  #       |> Map.replace(:cart, [existing_shoe])

  #     conn = Map.replace!(conn, :assigns, new_assigns)

  #     {:ok, view, html} = live(conn)

  #     render_click(view, "addToCart", %{"id" => existing_shoe.id, "size" => 8})

  #     html = render_click(view, "addToCart", %{"id" => shoe.id, "size" => 7})
  #     cart =
  #       html
  #       |> Floki.parse_document!()
  #       |> Floki.find("div.shoe-cart")
  #       |> Floki.find("span")
  #       |> Floki.text()

  #     assert cart =~ "items in cart: 2"
  #   end

  #   # test "showCheckoutModal event: updates assigns and renders checkout modal"

  #   # test "closeModal event: when preview is provided, updates assigns and closes preview modal"
  #   # test "closeModal event:  when checkout is provided, updates assigns and removes modal from html"

  #   # test "removeCartItem event: when a shoe id is provided, updates assigns, and renders updated cart"

  # end

  defp handle_multi_insert_setup do
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
