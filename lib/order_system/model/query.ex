defmodule OrderSystem.Query do
  defmacro __using__(_) do
    quote do
      import Ecto.Query

      def paginate(query, page, limit) do
        from(query,
          limit: ^limit,
          offset: ^((page - 1) * limit)
        )
      end
    end
  end
end
