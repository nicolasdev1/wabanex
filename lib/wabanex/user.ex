defmodule Wabanex.User do
  # Todo código que o espaço "Ecto.Schema" me permita usar vou conseguir utilizar aqui
  use Ecto.Schema

  # Com o "import" conseguimos importar funções do "Ecto.Changeset"
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:name, :email, :password]

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end
end
