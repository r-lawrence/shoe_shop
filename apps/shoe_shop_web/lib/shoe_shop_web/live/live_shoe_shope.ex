defmodule ShoeShopWeb.LiveShoeShop do
  @moduledoc """
    Controls the view and user actions of the web application.
  """
  use ShoeShopWeb, :live_view
  alias ShoeShop.Shoes

  @spec render(map()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    Phoenix.View.render(ShoeShopWeb.PageView, "home.html", assigns)
  end

  @spec mount(map(), any(), Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_params, _, socket) do
    {:ok,
     assign(socket,
       shoes: Shoes.get_type(:type, "Men"),
       cart: [],
       shoe_selection: "Men",
       preview: nil,
       show_checkout: false
     )}
  end

  @spec handle_event(String.t(), map(), Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_event("changeShoeTypeSelection", %{"value" => value}, %{assigns: assigns} = socket) do
    case assigns.shoe_selection != value do
      true ->
        {:noreply, assign(socket, shoes: Shoes.get_type(:type, value), shoe_selection: value)}

      false ->
        {:noreply, socket}
    end
  end

  def handle_event("renderShoePreview", %{"shoe_id" => id}, socket) do
    preview_shoe =
      Enum.find(socket.assigns.shoes, fn shoe ->
        shoe.id == id
      end)

    {:noreply, assign(socket, preview: preview_shoe)}
  end

  def handle_event("addToCart", %{"id" => id, "size" => size}, %{assigns: %{cart: cart}} = socket) do
    formatted_id = Enum.at(String.split(id, "id-"), 1)

    new_shoe =
      Enum.find(socket.assigns.shoes, fn shoe ->
        shoe.id == formatted_id
      end)

    new_shoe = generate_cart_display(new_shoe, size)

    {:noreply, assign(socket, cart: add_to_cart(cart, new_shoe), preview: nil)}
  end

  def handle_event("removeCartItem", %{"id" => id}, socket) do
    new_shoes =
      Enum.reject(socket.assigns.cart, fn shoe ->
        shoe.id == id
      end)

    {:noreply, assign(socket, cart: new_shoes)}
  end

  def handle_event("showCheckoutModal", _, socket) do
    {:noreply, assign(socket, show_checkout: true)}
  end

  def handle_event("closeModal", %{"modal" => value}, socket) do
    case value do
      "preview" ->
        {:noreply, assign(socket, preview: nil)}

      "checkout" ->
        {:noreply, assign(socket, show_checkout: false)}

      _ ->
        {:noreply, socket}
    end
  end

  defp add_to_cart(current_cart, new_shoe) do
    current_cart ++ [new_shoe]
  end

  defp generate_cart_display(new_shoe, size) do
    %{
      id: new_shoe.id,
      img_url: new_shoe.img_url,
      size: size,
      price: new_shoe.price,
      style: new_shoe.style,
      type: new_shoe.type,
      name: new_shoe.name
    }
  end
end
