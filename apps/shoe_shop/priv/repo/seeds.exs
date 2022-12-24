# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ShoeShop.Repo.insert!(%ShoeShop.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/male-exercise-shoe-1.png",
  type: "Men",
  style: "exercise",
  price: 100,
  sizes: [7.0, 7.5, 8.0],
  name: "Basic"
})

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/male-exercise-shoe-2.png",
  type: "Men",
  style: "exercise",
  price: 130,
  sizes: [7.0, 7.5, 8.0],
  name: "Enhanced"
})

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/male-exercise-shoe-3.png",
  type: "Men",
  style: "exercise",
  price: 250,
  sizes: [7.0, 7.5, 8.0],
  name: "Pro"
})

# male fashion shoes

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/male-fashion-shoe-1.png",
  type: "Men",
  style: "fashion",
  price: 175,
  sizes: [7.0, 7.5, 8.0],
  name: "Slicks"
})

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/male-fashion-shoe-2.png",
  type: "Men",
  style: "fashion",
  price: 115,
  sizes: [7.0, 7.5, 8.0],
  name: "Modern"
})

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/male-fashion-shoe-3.png",
  type: "Men",
  style: "fashion",
  price: 115,
  sizes: [7.0, 7.5, 8.0],
  name: "Modern Grey"
})

# female exercise shoes

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/female-exercise-shoe-1.png",
  type: "Women",
  style: "exercise",
  price: 100,
  sizes: [7.0, 7.5, 8.0],
  name: "basic"
})

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/female-exercise-shoe-2.png",
  type: "Women",
  style: "exercise",
  price: 130,
  sizes: [7.0, 7.5, 8.0],
  name: "Enhanced"
})

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/female-exercise-shoe-3.png",
  type: "Women",
  style: "exercise",
  price: 250,
  sizes: [7.0, 7.5, 8.0],
  name: "Pro"
})

# female fashion

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/female-fashion-shoe-1.png",
  type: "Women",
  style: "fashion",
  price: 175,
  sizes: [7.0, 7.5, 8.0],
  name: "Boots Black"
})

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/female-fashion-shoe-2.png",
  type: "Women",
  style: "fashion",
  price: 115,
  sizes: [7.0, 7.5, 8.0],
  name: "Boots Brown"
})

ShoeShop.Repo.insert!(%ShoeShop.Shoes.Shoe{
  id: Ecto.UUID.generate(),
  img_url: "/images/female-fashion-shoe-3.png",
  type: "Women",
  style: "fashion",
  price: 115,
  sizes: [7.0, 7.5, 8.0],
  name: "Boots Blue"
})
