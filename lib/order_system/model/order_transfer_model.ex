defmodule OrderSystem.OrderTransferModel do
  alias OrderSystem.{Repo, OrderTransfer, TransferModel}

  def create_order_transfer(attrs) do

    Repo.transaction(fn ->
      attrs
      |> add_ids()
      |> insert_transfers()
    end)
  end

  defp add_ids(%{transfer_to: _} = attrs) do
    attrs.transfer_to
    |> Enum.map(fn base_transfer ->
      Map.merge(base_transfer, %{order_id: attrs.order_id})
    end)
  end

  # defp insert(order, transfer) do
  #   transfer_id = Ecto.UUID.generate()
  #   Repo.insert(%OrderTransfer{
  #     order_id: order.id,
  #     transfer_id: transfer_id,
  #     transfer: %Transfer{
  #       id: transfer_id,
  #       amount: transfer.amount
  #     }
  #   })
  # end

  defp insert_transfers(transfer_to) do
    transfer_to
    |> Enum.map(&insert_transfer!/1)
    |> Enum.map(&insert_order_transfer/1)
  end

  defp insert_transfer!(transfer_attrs) do
    {:ok, transfer} = TransferModel.create_transfer(transfer_attrs)

    transfer_attrs
    |> Map.put(:transfer_id, transfer.id)
  end

  defp insert_order_transfer(attrs) do
    %OrderTransfer{}
    |> OrderTransfer.changeset(attrs)
    |> Repo.insert()
  end
end
