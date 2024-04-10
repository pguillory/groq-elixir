defmodule Groq.SentimentAnalysisExample do
  @default_categories ~w[clickbait harmful uplifting informative interesting]

  def analyze(content, opts \\ []) do
    categories = Keyword.get(opts, :categories, @default_categories)

    json_schema = %{
      sentiment_analysis: Map.new(categories, &{&1, "number (0-1)"})
    }

    system_prompt = """
    You are a sentiment analysis API that responds in JSON. The JSON schema is:

    #{Jason.encode!(json_schema, pretty: true)}
    """

    response =
      Groq.completions(
        messages: [
          %{role: "system", content: system_prompt},
          %{role: "user", content: "Text: #{content}"}
        ],
        response_format: :json
      )

    %{
      "choices" => [
        %{
          "message" => %{
            "content" => json_response
          }
        }
      ]
    } = response

    Jason.decode!(json_response, keys: :atoms)
    |> Map.get(:sentiment_analysis)
  end
end
