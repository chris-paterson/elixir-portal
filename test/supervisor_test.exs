defmodule SupervisorTest do
  use ExUnit.Case

  test "reopens portal" do
    Portal.shoot(:orange)
    Portal.shoot(:blue)

    portal = Portal.transfer(:orange, :blue, [1, 2, 3, 4])
    Portal.push_right(portal)

    Process.unlink(Process.whereis(:blue))
    Process.exit(Process.whereis(:blue), :shutdown)
    
    # Needed to allow process to be closed in time.
    :timer.sleep(1000)
    
    Portal.push_right(portal)
    assert Portal.Door.get(:orange) == [2, 1]
    assert Portal.Door.get(:blue) == [3]
  end

end