defmodule FrostmountWeb.PageController do
  use FrostmountWeb, :controller

  alias Frostmount.GameGenerator

  def home(conn, _params) do
    render(conn, :home)
  end

  def quick(conn, _params) do
    name = GameGenerator.name()
    strength = GameGenerator.strength()

    redirect(conn, to: "/battlefield?name=#{name}&strength=#{strength}")
  end
end
