defmodule ShoeShop.Repo.Migrations.CreateShoes do
  use Ecto.Migration

  def change do
    create table(:shoes, primary_key: false) do
      add :id, :binary_id, primary: true
      add :img_url, :string
      add :type, :string
      add :style, :string
      add :price, :integer
      add :sizes, {:array, :float}
      add :name, :string

      timestamps()
    end
  end
end
