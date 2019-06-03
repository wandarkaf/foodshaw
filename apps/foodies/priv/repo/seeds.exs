# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Foodies.Repo.insert!(%Foodies.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Foodies.Accounts
alias Foodies.Accounts.User

Accounts.create_user(%User{name: "Alonso", username: "Wandarkaf", role: "admin"})
