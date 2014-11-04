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
    Octobase.Server.command(text)
  end

  defp print({:ok, result}) do
    IO.puts(result |> inspect |> Colors.green)
  end

  defp print({:error, type, description}) do
    IO.puts "#{Colors.bold("ERROR")} #{type}: #{Colors.bold(description)}" |> Colors.red
  end
end
