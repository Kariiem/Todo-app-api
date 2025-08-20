defmodule TodoApiWeb.FallbackController do
  use TodoApiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: TodoApi.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :unkwown_params}) do
    conn
    |> put_status(:bad_request)
    |> json(%{errors: %{:bad_request}})
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> json(:not_found)
  end

end
