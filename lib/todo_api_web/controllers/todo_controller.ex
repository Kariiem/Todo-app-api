defmodule TodoApiWeb.TodoController do
  use TodoApiWeb, :controller

  alias TodoApi.Todo
  alias TodoApi.Repo

  action_fallback TodoApiWeb.FallbackController

  def index(conn, %{"completed" => completed?, "priority" => priority}) do
# It's generally best to keep business logic out of controllers. Phoenix contexts are designed to handle this kind of logic,
# which helps keep your code organized and easier to test.
# Right now, the code doesn't check whether the incoming parameters are valid
# If malformed data is sent, it could lead to errors or unintended behavior.
# Adding proper validation would make the app more resilient.
# The with macro is great for handling sequential operations with potential failures,
# but in this case, it seems to be used more for assignment than for error handling.
# It might be worth revisiting how it's being used to ensure we're also properly handling any error cases.
# Using changesets is a key part of Ecto design  they help validate input and protect against issues like SQL injection.
# raw parameters are being used directly, which could pose security risks.
# Wrapping the params in a changeset would help ensure data integrity and safety.
    with todos <- Repo.all_by(Todo, completed: completed?, priority: priority) do
      conn
      |> put_status(200)
      |> render(:index, %{todos: todos})
    end
  end

  def index(conn, %{"completed" => completed?}) do
    # Same comments as above apply here
    # you are using pattern matching to differentiate between the different index functions which is good
    # as it seems you are learning elixir pattern matching but in a real world application
    # you should be using a single index function and use query builders to filter the results based on the params
    # but you are still learning
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
  # you have prevented the user from getting all todos and instead return an error
  # NOTE: this clause is never entered due to map matching semantics
  def index(_, _) do
    {:error, :unkwown_params}
  end

  def create(conn, params) do
    with {:ok, todo} <- Todo.changeset(%Todo{},params) |> Repo.insert() do
        conn
        # For the future, when creating a resource the status code should be 201
        |> put_status(200)
        # You should return the entire resource
        |> render(:create, %{id: todo.id})
    end
  end

  # The function is named edit but should be update to follow REST conventions.
  def edit(conn, params) do
    with id <- Map.fetch!(params, "id"),
        # Why are you using get_by here instead of get?
         todo <- Repo.get_by(Todo, id: id),
         {:ok, updated_todo} <- Todo.changeset(todo, params) |> Repo.update() do
        conn
        |> put_status(200)
        |> render(:show, %{todo: updated_todo})
    end
  end

#   def create(conn, %{"todo" => todo_params}) do
#   case Todos.create_todo(todo_params) do
#     {:ok, todo} ->
#       conn
#       |> put_status(:created)
#       |> put_status(201)
#       |> render(:show, todo: todo)

#     {:error, changeset} ->
#       conn
#       |> put_status(:unprocessable_entity)
#       |> put_view(json: TodoApiWeb.ChangesetJSON)
#       |> render(:error, changeset: changeset)
#   end
# end

# def update(conn, %{"id" => id, "todo" => todo_params}) do
#   todo = Todos.get_todo!(id)

#   case Todos.update_todo(todo, todo_params) do
#     {:ok, todo} ->
#       conn
#      |> put_status(200)
#      |> render(:show, todo: todo)

#     {:error, changeset} ->
#       conn
#       |> put_status(:unprocessable_entity)
#       |> put_view(json: TodoApiWeb.ChangesetJSON)
#       |> render(:error, changeset: changeset)
#   end
# end

  def delete(conn, params) do
    with id <- Map.fetch!(params, "id"),
         todo <- Repo.get_by(Todo, id: id),
         {:ok, deleted_todo} <- Repo.delete(todo) do
        conn
        # Usually for delete we return 204 no content, not big issue though
        |> put_status(200)
        |> render(:show, %{todo: deleted_todo})
    end
  end


  def show(conn, %{"id" => id}) do
    # No error handling if the todo is not found
    # and will return a 200 with null body instead of a 404 not found
    with todo <- Repo.get(Todo, id) do
      conn
      |> put_status(200)
      |> render(:show, %{todo: todo})
    end
  end

end
