defmodule TodoApiWeb.TodoJSON do
  def index(%{msg: msg}) do
    %{data: msg}
  end
end
