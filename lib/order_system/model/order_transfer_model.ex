defmodule OrderSystem.OrderTransferModel do
  alias OrderSystem.{OrderTransfer}
  alias Ecto.Multi

  def create_order_transfer(
        multi \\ Multi.new(),
        key \\ :order_transfer,
        %{transfer_id: _, order_id: _} = attrs
      ) do
    multi
    |> Multi.insert(key, insert_order_transfer_changeset(attrs))
  end

  defp insert_order_transfer_changeset(attrs) do
    %OrderTransfer{}
    |> OrderTransfer.changeset(attrs)
  end
end
