defmodule TodoApiWeb.TodoController do
  use TodoApiWeb, :controller
  @moduledoc """
  """

  def index(conn, _params) do
    render(conn, :index, msg: "jello")
  end
end
