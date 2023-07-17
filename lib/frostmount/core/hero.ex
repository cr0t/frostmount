defmodule Frostmount.Core.Hero do
  @moduledoc """
  Hero repesents a character of our improvised RPG game party. Heros usually have names, some level
  of strength (which is basically a maximum possible damage), and an avatar (in this weird universe,
  the avatar is just a number).
  """

  defstruct ~w[name strength avatar]a

  def new(), do: %__MODULE__{}
  def new(fields), do: struct!(__MODULE__, fields)

  defmodule Validator do
    @moduledoc """
    This module is going to be used in the Lobby interactive form.
    """

    import Ecto.Changeset

    @types %{name: :string, avatar: :string, strength: :integer}

    def changeset(%Frostmount.Core.Hero{} = hero, attrs) do
      {hero, @types}
      |> cast(attrs, Map.keys(@types))
      |> validate_required([:name])
      |> validate_length(:name, min: 5, max: 100)
      |> validate_number(:strength, greater_than: 0, less_than: 6)
    end
  end
end
