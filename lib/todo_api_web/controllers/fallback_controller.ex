defmodule TodoApiWeb.FallbackController do
  use TodoApiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: TodoApi.ChangesetJSON) # Incorrect reference see the comment in changeset_json.ex
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :unkwown_params}) do
    conn
    |> put_status(:bad_request)
    # I had to fix this to make the application compile, Make sure to test your code before submission
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> json(:not_found)
  end

end
