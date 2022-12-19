# ShoeShop

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/r-lawrence/shoe_shop/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/r-lawrence/shoe_shop/tree/main)
[![codecov](https://codecov.io/github/r-lawrence/shoe_shop/branch/main/graph/badge.svg?token=H33XW1I7PD)](https://codecov.io/github/r-lawrence/shoe_shop)

> Repo still in progress, check branches for most updated code.

A phoenix umbrella application built using live view, to demo imitate a fake e-commerce shoe shopping experience.  This application was generated using the `phx.new` phoenix project generator, then modified accordingly to achieve desired result.
## Pre-req Dependancies

In to be able to compile and run the application, we will need to install Elixir/Erlang and PostgreSQL.  Thankfully, Phoenix provides really great documentation and you can find all the information needed for specific OS install from this [page](https://hexdocs.pm/phoenix/installation.html).
## Instructions

To install your dependancies and compile your the application:
  * ensure locally, Postgres is running.  I use homebrew, so for me its `brew services start postgresql`
  * clone this repository 
  * from the `shoe_shop_umbrella` root directory, install depenencies with `mix deps.get`
  * create and migrate the shoe_store database with `mix setup`

To start your Phoenix server:
  * Start Phoenix endpoint with `mix phx.server`
  * http://localhost:4000/ to view application

## Notes
  * static images are royalty free and came from [Pixabay](https://pixabay.com/)
  * multiple oiptimizations can be done throughout both shoe_shop and shoe_shop_web applications.  This project was just built with an intial two day constraint, so updates may or may not come.
  * display is viewed best on full screen desktop monitor.  Because of time constraint, application functionality took priority.




  