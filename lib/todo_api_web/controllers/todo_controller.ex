defmodule TodoApiWeb.TodoController do
  use TodoApiWeb, :controller

  alias TodoApi.Todo
  alias TodoApi.Repo

  action_fallback TodoApiWeb.FallbackController

  def index(conn, %{"completed" => completed?, "priority" => priority}) do
    with todos <- Repo.all_by(Todo, completed: completed?, priority: priority) do
      conn
      |> put_status(200)
      |> render(:index, %{todos: todos})
    end
  end

  def index(conn, %{"completed" => completed?}) do
    with todos <- Repo.all_by(Todo, completed: completed?) do
      conn
      |> put_status(200)
      |> render(:index, %{todos: todos})
    end
  end

  def index(conn, %{"priority" => priority}) do
    with todos <- Repo.all_by(Todo, priority: priority) do
      conn
      |> put_status(200)
      |> render(:index, %{todos: todos})
    end
  end
  # NOTE: this clause is never entered due to map matching semantics
  def index(_, _) do
    {:error, :unkwown_params}
  end

  def create(conn, params) do
    with {:ok, todo} <- Todo.changeset(%Todo{},params) |> Repo.insert() do
        conn
        |> put_status(200)
        |> render(:create, %{id: todo.id})
    end
  end

  def edit(conn, params) do
    with id <- Map.fetch!(params, "id"),
         todo <- Repo.get_by(Todo, id: id),
         {:ok, updated_todo} <- Todo.changeset(todo, params) |> Repo.update() do
        conn
        |> put_status(200)
        |> render(:show, %{todo: updated_todo})
    end
  end

  def delete(conn, params) do
    with id <- Map.fetch!(params, "id"),
         todo <- Repo.get_by(Todo, id: id),
         {:ok, deleted_todo} <- Repo.delete(todo) do
        conn
        |> put_status(200)
        |> render(:show, %{todo: deleted_todo})
    end
  end


  def show(conn, %{"id" => id}) do
    with todo <- Repo.get(Todo, id) do
      conn
      |> put_status(200)
      |> render(:show, %{todo: todo})
    end
  end

end
