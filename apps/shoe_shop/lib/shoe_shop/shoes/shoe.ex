defmodule ShoeShop.Shoes.Shoe do
  @moduledoc """
    Reponsible for establishing the Shoe type and shoes schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          img_url: String.t(),
          type: String.t(),
          style: String.t(),
          price: integer(),
          sizes: list(),
          name: String.t()
        }

  @primary_key {:id, :binary_id, autogenerate: false}
  schema "shoes" do
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
    |> cast(attrs, [:id, :img_url, :type, :style, :price, :sizes, :name])
    |> validate_required([])
  end
end
