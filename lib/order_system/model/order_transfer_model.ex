defmodule OrderSystem.OrderTransferModel do
  alias OrderSystem.{Repo, OrderTransfer, TransferModel}
  alias Ecto.Multi

  def create_order_transfer(%{transfer_id: _, order_id: _} = attrs) do
    Multi.new()
    |> Multi.insert(:order_transfer, insert_order_transfer_changeset(attrs))
  end

  defp insert_order_transfer_changeset(attrs) do
    %OrderTransfer{}
    |> OrderTransfer.changeset(attrs)
  end
end
