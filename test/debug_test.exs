defmodule Test.Debug do
  use ExUnit.Case
  require Debug

  test "info" do
    assert Debug.info("foo") == "foo"
    assert Debug.info(1..100, limit: :infinity) == 1..100
  end

  test "debug" do
    assert Debug.debug("foo") == "foo"
  end

  test "alert" do
    assert Debug.alert("foo") == "foo"
  end

  test "error" do
    assert Debug.error({:error, "message"}) == {:error, "message"}
  end

  test "log" do
    assert Debug.log(["foo", "bar", "baz"]) == ["foo", "bar", "baz"]
  end

  test "warn" do
    assert Debug.warn("foo", nil) == "foo"
    assert Debug.warn(:foo, nil) == :foo
  end
end
