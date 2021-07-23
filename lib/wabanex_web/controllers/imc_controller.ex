# Agrupamentos de funções do IMCController
defmodule WabanexWeb.IMCController do
  # Define o espaço como uma controller e ganha algumas funções como "json()", "put_status()"
  use WabanexWeb, :controller

  # Define o acesso ao espaço "Wabanex.IMC" como "IMC"
  alias Wabanex.IMC

  # Função que possui referência no Router e retorna resposta como JSON
  def index(connection, params) do
    params
    |> IMC.calculate()
    |> handle_response(connection)
  end

  defp handle_response({:ok, result}, connection),
    do: render_response(connection, result, :ok)

  defp handle_response({:error, reason}, connection),
    do: render_response(connection, reason, :bad_request)

  defp render_response(connection, result, status) do
    connection
    |> put_status(status)
    |> json(result)
  end
end
