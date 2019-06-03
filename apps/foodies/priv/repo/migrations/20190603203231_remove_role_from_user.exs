defmodule Foodies.Repo.Migrations.RemoveRoleFromUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :role
    end
  end
end
