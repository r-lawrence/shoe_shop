defmodule ShoeShopWeb.PageView do
  use ShoeShopWeb, :view

  @spec render_summary(map()) :: Phoenix.HTML.Safe
  def render_summary(assigns) do
    final_values = calculate_summary(assigns)

    ShoeShopWeb.PageView.render("checkout_summary.html", final_values)
  end

  @spec calculate_summary(map()) :: list()
  defp calculate_summary(%{cart: cart} = _assigns) do
    subtotal = get_subtotal(cart)
    tax = get_est_tax(subtotal)

    [
      subtotal: "$" <> to_string(subtotal) <> ".00",
      shipping: get_shipping(cart),
      tax: "$" <> to_string(tax),
      total: "$" <> to_string(get_total(subtotal, tax))
    ]
  end

  defp get_subtotal(cart) do
    prices =
      Enum.map(cart, fn item ->
        item.price
      end)

    Enum.sum(prices)
  end

  defp get_shipping(cart) do
    case length(cart) do
      0 ->
        "$0.00"
      _ ->
        "$8.00"
    end
  end

  defp get_total(subtotal, tax) do
    case subtotal do
      0 ->
        "0.00"
      _ ->
        (subtotal + tax + 8.00) |> Float.floor(2)
    end
  end

  defp get_est_tax(subtotal) do
    case subtotal do
      0 ->
        "$0.00"
      _ ->
        (subtotal * 0.0635) |> Float.floor(2)
    end
  end
end
