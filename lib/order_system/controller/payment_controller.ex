defmodule OrderSystem.PaymentController do
  alias Ecto.Multi
  alias OrderSystem.{Repo, OrderTransfer, Transfer}

  def pay(%{order_id: order_id, transfer_to: _} = attrs) do
    pay_multi(attrs)
    |> Repo.transaction()
  end

  def pay_multi(%{order_id: order_id, transfer_to: _} = attrs) do
    attrs.transfer_to
    |> Enum.with_index()
    |> Enum.reduce(Ecto.Multi.new(), fn {transfer_info, index}, multi ->
      transfer_id = Ecto.UUID.generate()

      # TODO: use changesets here?
      order_transfer = %OrderTransfer{
        order_id: order_id,
        transfer: %Transfer{
          id: transfer_id,
          amount: transfer_info.amount,
          account_id: transfer_info.account_id
        }
      }

      Ecto.Multi.insert(multi, transaction_id(index), order_transfer)
    end)
  end

  defp transaction_id(index) when is_integer(index) do
    "transaction_#{index}"
  end
end
