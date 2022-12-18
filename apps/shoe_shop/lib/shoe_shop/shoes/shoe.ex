defmodule ShoeShop.Shoes.Shoe do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: false}
  schema "shoes" do

    # field :id, :binary_id, primary: true

    field :img_url, :string
    field :type, :string
    field :style, :string
    field :price, :integer
    field :sizes, {:array, :float}
    field :name, :string
    timestamps()
  end

  @doc false
  def changeset(shoes, attrs) do
    shoes
    |> cast(attrs, [:img_url, :type, :style, :price, :sizes, :name])
    |> validate_required([])
  end
end
