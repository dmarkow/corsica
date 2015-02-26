defmodule Corsica.Simple do
  @moduledoc false

  import Plug.Conn
  import Corsica, only: [put_common_headers: 2]

  def handle_req(conn, opts) do
    conn
    |> put_expose_headers_header(opts)
    |> put_common_headers(opts)
  end

  defp put_expose_headers_header(conn, opts) do
    expose_headers = opts[:expose_headers]
    if expose_headers && expose_headers != [] do
      value = Enum.join(expose_headers, ", ")
      put_resp_header(conn, "access-control-expose-headers", value)
    else
      conn
    end
  end
end