# Portal

Download dependencies using `mix deps.get`.

Run tests using `mix test`.


## Separate server test
1. Start first node using `iex --sname iliad --cookie secret -S mix`
2. Open new terminal and run `iex --sname odyssey --cookie secret -S mix`

iliad
```
Portal.shoot(:blue)

blue = {:blue, :"iliad@COMPUTER-NAME"}
orange = {:orange, :"odyssey@COMPUTER-NAME"}

portal = Portal.transfer(orange, blue, [1, 2, 3, 4])
Portal.push_right(portal)
```

odyssey
```
Portal.shoot(:orange)

blue = {:blue, :"iliad@COMPUTER-NAME"}
orange = {:orange, :"odyssey@COMPUTER-NAME"}

Portal.Door.get(orange)
Portal.Door.get(blue)
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `portal` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:portal, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/portal](https://hexdocs.pm/portal).

