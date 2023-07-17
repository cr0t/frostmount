defmodule FrostmountWeb.PageController do
  use FrostmountWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
