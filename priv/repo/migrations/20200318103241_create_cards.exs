defmodule Tarot.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :deck, :string
      add :name, :string
      add :value, :integer
      add :suit, :string
      add :image, :string
      add :state, :integer, dafault: 0
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:cards, [:user_id])
  end
end
