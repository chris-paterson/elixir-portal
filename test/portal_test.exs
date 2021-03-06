defmodule PortalTest do
  use ExUnit.Case
  doctest Portal

  test "transfer" do
    Portal.Door.start_link(:orange)
    Portal.Door.start_link(:blue)

    Portal.transfer(:orange, :blue, [1, 2, 3])
    assert Portal.Door.get(:orange) == [3, 2, 1]
  end

  test "push_right" do
    Portal.Door.start_link(:orange)
    Portal.Door.start_link(:blue)

    portal = Portal.transfer(:orange, :blue, [1, 2, 3])
    Portal.push_right(portal)

    assert Portal.Door.get(:orange) == [2, 1]
    assert Portal.Door.get(:blue) == [3]
  end

  test "push_left" do
    Portal.Door.start_link(:orange)
    Portal.Door.start_link(:blue)

    portal = Portal.transfer(:orange, :blue, [1, 2, 3])
    Portal.push_right(portal)
    Portal.push_left(portal)

    assert Portal.Door.get(:orange) == [3, 2, 1]
    assert Portal.Door.get(:blue) == []
  end
end
