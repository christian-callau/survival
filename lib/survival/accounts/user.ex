defmodule Survival.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :fbid, :string
    field :name, :string
    field :role, :string, default: "user"

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:fbid, :name, :role])
    |> validate_required([:fbid, :name, :role])
  end
end
