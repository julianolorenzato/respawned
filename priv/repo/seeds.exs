# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Respawned.Repo.insert!(%Respawned.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# alias Respawned.Repo
# alias Respawned.Communities.Community
# alias Respawned.Accounts.{Account, Profile}

# account =
#   %{
#     "email" => "admin@repawned.com",
#     "password" => "password"
#   }
#   |> Account.insert_changeset()
#   |> Repo.insert!()

# communities = [
#   %Community{
#     name: "VALORANT",
#     kind: :official,
#     cover_path: ~p"/images/communities_covers/valorant.png"
#   }
# ]
