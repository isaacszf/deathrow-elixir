defmodule Utils do
  def parse_doc(body) do
    case Floki.parse_document(body) do
      {:ok, doc} -> doc
      {:error, reason} -> IO.inspect(reason)
    end
  end

  def get_page(url) do
    HTTPoison.start()

    headers = [Accept: "Application/json; Charset=utf-8"]
    options = [ssl: [{:versions, [:"tlsv1.2"]}, verify: :verify_none]]

    case HTTPoison.get(url, headers, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> body
      {:ok, %HTTPoison.Response{status_code: 404}} -> :ignore
      {:error, %HTTPoison.Error{reason: reason}} -> IO.inspect(reason)
    end
  end
end
