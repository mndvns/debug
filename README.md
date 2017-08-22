# Debug

A simple code inspection tool for development.

## Usage

```elixir
defmodule MyModule do
  use Debug
end
```

## Basic example

Via `test/debug_test.exs`:

```elixir
Debug.info("foo")
Debug.info(1..100, limit: :infinity)

Debug.debug("foo")

Debug.alert("foo")

Debug.error({:error, "message"})

Debug.log(["foo", "bar", "baz"])

Debug.warn("foo", nil)
Debug.warn(:foo, nil)
```

Yields:

![Debug example](http://i.imgur.com/4Dh00di.png "Debug example")

## Useful example

I made this package so I could inspect values via pipes without losing the context.

With `IO.inspect/1`:

```elixir
%SomeStruct{}
|> transform()
|> IO.inspect()
|> transform_again()
|> IO.inspect()
```

This is fine for quick inspection, but it becomes unwieldy as there is no frame of reference for
the output.

With `Debug`:

```elixir
%SomeStruct{}
|> transform()
|> Debug.log(:first_transform)
|> transform_agein()
|> Debug.info()
```

The first `Debug.log/2` will prepend `:first_transform` to the output in addition to the code file and line.

In the second `Debug.info/1`, the source code is prepended to the output. So matter where the inspecting function is,
you can always find your way back to the source to remove or modify it.

You can see below how `Debug` works around your piped values.

![Debug example piping](http://i.imgur.com/QcFdr9D.png "Debug example piping")

## Installation

```elixir
def deps do
  [
    {:debug, "~> 0.1.0"}
  ]
end
```
