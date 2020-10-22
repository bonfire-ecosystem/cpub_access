defmodule CommonsPub.Access.AccessGrant do
  @moduledoc """
  """

  use Pointers.Pointable,
    otp_app: :cpub_access,
    table_id: "1NSERTSAP01NTER1NT0AC1RC1E",
    source: "cpub_access_access_grant"

  alias CommonsPub.Access.{Acl, AccessGrant, Foam}
  alias Pointers.{Changesets, Pointer}

  pointable_schema do
    belongs_to :foam, Foam
    belongs_to :subject, Pointer
    belongs_to :acl, Acl
  end

  def changeset(access_grant \\ %AccessGrant{}, attrs, opts \\ []),
    do: Changesets.auto(access_grant, attrs, opts, [])
 
end
defmodule CommonsPub.Access.AccessGrant.Migration do

  use Ecto.Migration
  import Pointers.Migration
  alias CommonsPub.Access.{Acl, AccessGrant, Foam}

  def migrate_access_grant(dir \\ direction())
  def migrate_access_grant(:up), do: create_access_grant_table
  def migrate_access_grant(:down), do: drop_access_grant_table()

  defmacro create_access_grant_table() do
    quote do
      CommonsPub.Access.AccessGrant.Migration.create_access_grant_table do
      end
    end
  end

  defmacro create_access_grant_table([do: body]) do
    quote do
      Pointers.Migration.create_pointable_table(CommonsPub.Access.AccessGrant) do
        Ecto.Migration.add :foam_id,
          Pointers.Migrations.strong_pointer(CommonsPub.Access.Foam)
        Ecto.Migration.add :subject_id,
          Pointers.Migrations.strong_pointer()
        Ecto.Migration.add :acl_id,
          Pointers.Migrations.strong_pointer(CommonsPub.Access.Acl)
        unquote_splicing(body)
      end
    end
  end

  def drop_access_grant_table(), do: drop_pointable_table(AccessGrant)

end
