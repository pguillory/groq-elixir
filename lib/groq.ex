defmodule Groq do
  defp api_key do
    Application.fetch_env!(:groq, :api_key)
  end

  def default_model do
    "mixtral-8x7b-32768"
  end

  defp get_model(opts) do
    Keyword.get_lazy(opts, :model, fn ->
      Application.get_env(:groq, :model, default_model())
    end)
  end

  defp response_format_opt(body, opts) do
    case Keyword.fetch(opts, :response_format) do
      {:ok, :json} ->
        Map.put(body, :response_format, %{type: "json_object"})

      :error ->
        body
    end
  end

  def completions(opts \\ []) do
    body = %{
      model: get_model(opts),
      messages: Keyword.get(opts, :messages, [])
    }

    body = response_format_opt(body, opts)

    response =
      Req.post!(
        url: "https://api.groq.com/openai/v1/chat/completions",
        auth: {:bearer, api_key()},
        json: body
      )

    # IO.inspect(response.headers)

    response.body
  end
end
