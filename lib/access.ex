defmodule CommonsPub.Access.Access do
  @moduledoc """
  """

  use Pointers.Pointable,
    otp_app: :cpub_accesss,
    table_id: "ABVNCH0FPERM1SS10NS1NA11ST",
    source: "cpub_access_access"

  alias CommonsPub.Access.Access
  alias Pointers.Changesets

  pointable_schema do
  end

  def changeset(access \\ %Access{}, attrs, opts \\ []),
    do: Changesets.auto(access, attrs, opts, [])
 
end
defmodule CommonsPub.Access.Access.Migration do

  use Ecto.Migration
  import Pointers.Migration
  alias CommonsPub.Access.Access

  # create_access_table/{0,1}

  defp make_access_table(exprs) do
    quote do
      require Pointers.Migration
      Pointers.Migration.create_pointable_table(CommonsPub.Access.Access) do
        unquote_splicing(exprs)
      end
    end
  end

  defmacro create_access_table(), do: make_access_table([])
  defmacro create_access_table([do: {_, _, body}]), do: make_access_table(body)

  # drop_access_table/0

  def drop_access_table(), do: drop_pointable_table(Access)

  # migrate_access/{0,1}

  defp ma(:up), do: make_access_table([])
  defp ma(:down) do
    quote do
      require CommonsPub.Access.Access.Migration
      CommonsPub.Access.Access.Migration.drop_access_table()
    end
  end

  defmacro migrate_access() do
    quote do
      if Ecto.Migration.direction() == :up,
        do: unquote(ma(:up)),
        else: unquote(ma(:down))
    end
  end
  defmacro migrate_access(dir), do: ma(dir)

end
