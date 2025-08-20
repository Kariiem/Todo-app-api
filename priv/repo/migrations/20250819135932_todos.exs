defmodule TodoApi.Repo.Migrations.Todos do
  use Ecto.Migration

  def change do

  end
end

defmodule TodoApi.Repo.Migrations.Todos do
  use Ecto.Migration

  def change do
    create table("todos") do
      add :title, :string, size: 100
      add :description, :string
      add :completed, :boolean, default: false
      add :priority, :integer

      timestamps()
    end

  end
end
