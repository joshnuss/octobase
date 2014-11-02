defmodule Octobase.CLI do
  def main(args) do
    switches = [version: :boolean, help: :boolean]
    aliases  = [v: :version, h: :help]

    {options, parameters, _} = OptionParser.parse(args, switches: switches, aliases: aliases)

    version = Keyword.get(options, :version)

    banner

    if !version do
      case parameters do
        [database] -> IO.puts("Connected to #{database}")
        _ -> false
      end

      loop
    end
  end

  defp banner do
    IO.puts "octobase v0.0.1"
  end

  defp loop do
    case read do
      "exit" -> false
      "quit" -> false

      command ->
        command |> eval |> print
        loop
    end
  end

  defp read do
    IO.gets("octo> ") |> String.strip
  end

  defp eval(text) do
    {:ok, tokens, _} = text |> to_char_list |> :command_lexer.string
    {:ok, ast} = :command_parser.parse(tokens)

    ast
  end

  defp print(result) do
    IO.inspect result
  end
end
