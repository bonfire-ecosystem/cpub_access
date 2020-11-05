defmodule CommonsPub.Access.AccessGrant do
  @moduledoc """
  """

  use Pointers.Pointable,
    otp_app: :cpub_access,
    table_id: "1NSERTSAP01NTER1NT0AC1RC1E",
    source: "cpub_access_access_grant"

  alias CommonsPub.Access.{Access, AccessGrant}
  alias Pointers.{Changesets, Pointer}

  pointable_schema do
    belongs_to :subject, Pointer
    belongs_to :access, Access
  end

  def changeset(access_grant \\ %AccessGrant{}, attrs, opts \\ []),
    do: Changesets.auto(access_grant, attrs, opts, [])
 
end
defmodule CommonsPub.Access.AccessGrant.Migration do

  use Ecto.Migration
  import Pointers.Migration
  alias CommonsPub.Access.AccessGrant

  @access_grant_table AccessGrant.__schema__(:source)
  @unique_index [:subject_id, :access_id]
  @secondary_index [:access_id]

  # create_access_grant_table/{0,1}

  defp make_access_grant_table(exprs) do
    quote do
      Pointers.Migration.create_pointable_table(CommonsPub.Access.AccessGrant) do
        Ecto.Migration.add :subject_id,
          Pointers.Migrations.strong_pointer()
        Ecto.Migration.add :access_id,
          Pointers.Migrations.strong_pointer(CommonsPub.Access.Access)
        unquote_splicing(exprs)
      end
    end
  end

  defmacro create_access_grant_table(), do: make_access_grant_table([])
  defmacro create_access_grant_table([do: exprs]), do: make_access_grant_table(exprs)

  # drop_access_grant_table/0

  def drop_access_grant_table(), do: drop_pointable_table(AccessGrant)

  # create_acl_grant_unique_index/{0,1}

  defp make_access_grant_unique_index(opts) do
    quote do
      Ecto.Migration.create_if_not_exists(
        Ecto.Migration.unique_index(unquote(@access_grant_table), unquote(@unique_index), unquote(opts))
      )
    end
  end

  defmacro create_access_grant_unique_index(opts \\ [])
  defmacro create_access_grant_unique_index(opts), do: make_access_grant_unique_index(opts)

  def drop_access_grant_unique_index(opts \\ [])
  def drop_access_grant_unique_index(opts), do: drop_if_exists(unique_index(@access_grant_table, @unique_index, opts))

  defp make_access_grant_secondary_index(opts) do
    quote do
      Ecto.Migration.create_if_not_exists(
        Ecto.Migration.index(unquote(@access_grant_table), @secondary_index, unquote(opts))
      )
    end
  end

  defmacro create_access_grant_secondary_index(opts \\ [])
  defmacro create_access_grant_secondary_index(opts), do: make_access_grant_secondary_index(opts)

  def drop_access_grant_secondary_index(opts \\ [])
  def drop_access_grant_secondary_index(opts), do: drop_if_exists(index(@access_grant_table, @secondary_index, opts))

  # migrate_access_grant/{0,1}

  defp mag(:up), do: make_access_grant_table([])
  defp mag(:down) do
    quote do
      CommonsPub.Accesss.AccessGrant.Migration.drop_access_grant_secondary_index()
      CommonsPub.Accesss.AccessGrant.Migration.drop_access_grant_unique_index()
      CommonsPub.Accesss.AccessGrant.Migration.drop_access_grant_table()
    end
  end

  defmacro migrate_access_grant(dir \\ direction()), do: mag(dir)

end
