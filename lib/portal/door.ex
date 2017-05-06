defmodule Portal.Door do
  @doc """
  Starts a door with a given `colour`.

  The colour is given as a name so we can identify the door by the colour name
  instead of using a PID.
  """
  def start_link(colour) do
    Agent.start_link(fn -> [] end, name: colour)
  end

  @doc """
  Get the data currently in the `door`.
  """
  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  @doc """
  Pushes `value` into the door.
  """
  def push(door, value) do
    Agent.update(door, fn list -> [value | list] end)
  end

  @doc """
  pops a value from the `door`.

  Returns `{:ok, value}` if there is a value or `{:error}` if the hole is 
  currently empty.
  """
  def pop(door) do
    Agent.get_and_update(door, fn 
      [] -> {:error, []}
      [head | tail] -> {{:ok, head}, tail}
    end)
  end
end