defmodule TodoApiWeb.TodoJSON do

  def index(%{todos: todos}) do
    %{data: todos}
  end

  def create(%{id: id}) do
    %{data: id}
  end

  def show(%{todo: todo}) do
    %{data: todo}
  end


end
