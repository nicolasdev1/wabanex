# Agrupamento de funções do IMC
defmodule Wabanex.IMC do
  # Lida com as informações que recebe do IMCController
  def calculate(%{"filename" => filename}) do
    filename
    |> File.read()
    |> handle_file()
  end

  # Lida com o arquivo em caso de sucesso
  defp handle_file({:ok, content}) do
    data =
      content
      |> String.split("\r\n")
      |> Enum.map(fn line -> parse_line(line) end)
      |> Enum.into(%{})

    {:ok, data}
  end

  # Lida com o arquivo em caso de erro
  defp handle_file({:error, _reason}) do
    {:error, "Error while opening the file"}
  end

  # Faz o processamento de cada linha do arquivo
  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  # Efetua o cálculo do IMC
  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
