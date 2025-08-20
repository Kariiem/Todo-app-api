defmodule TodoApi.Todo do
  use Ecto.Schema

  @derive {Jason.Encoder, except: [:__meta__, :inserted_at, :updated_at]}
  schema "todos" do
    field :title, :string
    field :description, :string
    field :completed, :boolean
    field :priority, :integer

    timestamps()
  end

  @doc false
  def changeset(todo, params \\ %{}) do
    todo
    |> Ecto.Changeset.cast(params, [:title, :priority, :description, :completed])
    |> Ecto.Changeset.validate_required([:title])
    |> Ecto.Changeset.validate_length(:title, min: 1, max: 100)
    |> Ecto.Changeset.validate_inclusion(:priority, 1..3)
  end
end
