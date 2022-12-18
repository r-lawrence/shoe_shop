defmodule ShoeShop.Repo do
  use Ecto.Repo,
    otp_app: :shoe_shop,
    adapter: Ecto.Adapters.Postgres
end
