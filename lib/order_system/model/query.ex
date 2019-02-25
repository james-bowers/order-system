defmodule OrderSystem.Query do
  defmacro __using__(_) do
    quote do
      import Ecto.Query

      def paginate(query, options) do
        limit = Keyword.get(options, :limit, 10)
        page = Keyword.get(options, :page, 1)

        from(query,
          limit: ^limit,
          offset: ^((page - 1) * limit)
        )
      end
    end
  end
end
