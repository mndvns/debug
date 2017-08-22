defmodule Debug.Helper do
  defmacro debug_type(name, color, bg) do
    bg = apply(IO.ANSI, bg, [])
    color = apply(IO.ANSI, color, [])

    quote location: :keep do
      defmacro unquote(name)(message, opts \\ []) do
        create(unquote(name), unquote(color), unquote(bg), message, opts)
      end
    end
  end
end

defmodule Debug do
  import IO.ANSI
  import Debug.Helper

  @defaults [base: :decimal, binaries: :infer, char_lists: :infer,
             charlists: :infer, limit: 50, pretty: false,
             safe: true, structs: true, width: 80]

  debug_type(:alert, :magenta, :magenta_background)
  debug_type(:debug, :default_color, :white_background)
  debug_type(:info, :green, :green_background)
  debug_type(:log, :blue, :blue_background)
  debug_type(:warn, :yellow, :yellow_background)
  debug_type(:error, :red, :red_background)

  defp create(type, color, bg, message, opts) when is_atom(opts) do
    create(type, color, bg, [{opts, message}], @defaults)
  end

  defp create(type, color, bg, message, opts) do
    {key, value} = format(message, opts, color, bg)
    quote bind_quoted: binding(), location: :keep do
      %{file: file, line: line} = __ENV__

      path = Path.relative_to_cwd(file)

      prefix = "#{color}#{type}(#{path}:#{line})>"

      text = if opts[:inspect] != false, do: inspect(value, opts), else: value

      message = "#{key} #{color}#{text}"

      output = "#{prefix} #{message}#{reset()}"

      IO.puts(output)

      value
    end
  end

  defp format([{atom, value}], opts, color, bg) when is_atom(atom) do
    key = format_key(atom, opts, color, bg)
    {key, value}
  end
  defp format(value, _opts, _color, bg) do
    key = Macro.to_string(value) |> format_key_bold(bg)
    {key, value}
  end

  defp format_key(key, _opts, color, bg) do
    case (String.split(to_string(key), "!") |> Enum.reverse()) do
      ["" | parts] ->
        Enum.reverse(parts) |> Enum.join("") |> format_key_bold(bg)
      _ ->
        format_key_underline(key)
    end
  end

  defp format_key_underline(key) do
    Enum.join([underline(), to_string(key), no_underline()])
  end
  defp format_key_bold(key, bg) do
    Enum.join([reset(), bg, black(), " ", to_string(key), " ", reset()])
  end
end
