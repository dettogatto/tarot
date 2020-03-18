# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tarot.Repo.insert!(%Tarot.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Tarot.Repo.insert!(%Tarot.Card{deck: "arcani_minori", name: "asso di ori", image: "", value: 1, suit: ""})
