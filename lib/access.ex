defmodule CommonsPub.Access.Access do
  @moduledoc """
  """

  use Pointers.Pointable,
    otp_app: :cpub_accesss,
    table_id: "ABVNCH0FPERM1SS10NS1NA11ST",
    source: "cpub_access_access"

  alias CommonsPub.Access.Access
  alias Pointers.{Changesets, Pointer}

  pointable_schema do
  end

  def changeset(access \\ %Access{}, attrs, opts \\ []),
    do: Changesets.auto(access, attrs, opts, [])
 
end
defmodule CommonsPub.Access.Access.Migration do

  use Ecto.Migration
  import Pointers.Migration
  alias CommonsPub.Access.Access

  defmacro create_access_table(), do: make_access_table([])
  defmacro create_access_table([do: body]), do: make_access_table(body)

  defp make_access_table(exprs) do
    quote do
      Pointers.Migration.create_pointable_table(Access) do
        unquote_splicing(exprs)
      end
    end
  end

  def drop_access_table(), do: drop_pointable_table(Access)

  def migrate_access(dir \\ direction())
  def migrate_access(:up), do: create_access_table
  def migrate_access(:down), do: drop_access_table()

end
