defmodule Octobase.Server do
  def command(text) do
    case text |> to_char_list |> :command_lexer.string do
      {:ok, tokens, _} ->
        parse(tokens)
      {:error, {_, :command_lexer, {:illegal, data}}, _} ->
        {:error, :illegal, to_string(data)}
    end
  end

  defp parse(tokens) do
    case :command_parser.parse(tokens) do
      {:error, {_, :command_parser, error}} ->
        {:error, :invalid, to_string(error)}
      other -> other
    end
  end
end
