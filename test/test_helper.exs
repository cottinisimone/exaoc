ExUnit.start()

defmodule SlowTestCase do
  defmacro __using__(_opts) do
    quote do
      @moduletag timeout: 240_000
      IO.puts("Testing [#{__MODULE__}] takes significant time..")
    end
  end
end
