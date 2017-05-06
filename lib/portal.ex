defmodule Portal do
  defstruct [:left, :right]

  @doc """
  Starts transfering `data` from `left` to `right`.
  """
  def transfer(left, right, data) do
    # First add all data to the portal on the left
    for item <- data do
      Portal.Door.push(left, item)
    end

    %Portal{left: left, right: right}
  end

  @doc """
  Pushes the data to the right in the given `portal`.
  """
  def push_right(portal) do
    # See if we can pop data from left. If so, push the popped data to the 
    # right. Otherwise, do nothing.
    case Portal.Door.pop(portal.left) do
      :error -> :ok
      {:ok, head} -> Portal.Door.push(portal.right, head)
    end

    # Return the portal itself.
    portal
  end

  @doc """
  Shoots a new door with the given `colour`
  """
  def shoot(colour) do
    Supervisor.start_child(Portal.Supervisor, [colour])
  end

end


defimpl Inspect, for: Portal do
  def inspect(%Portal{left: left, right: right}, _) do
    left_door = inspect(left)
    right_door = inspect(right)

    left_data = inspect(Enum.reverse(Portal.Door.get(left)))
    right_data = inspect(Portal.Door.get(right))

    max = max(String.length(left_door), String.length(left_data))

    """
    # Portal<
      #{String.rjust(left_door, max)} <=> #{right_door}
      #{String.rjust(left_data, max)} <=> #{right_data}
    >
    """
  end
end