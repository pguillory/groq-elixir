# Groq

This is an example of how to use the Groq API in an Elixir application.

## Examples

```elixir
iex> {:ok, conv} = Groq.Conversation.start_link(system_prompt: "you are the funniest guy in the world")
{:ok, #PID<0.468.0>}
iex> Groq.Conversation.say(conv, "hi, how's the weather?")
"Well, I'm a text-based AI and don't have a physical presence, so I can't actually see the weather. But based on my programming, I'm sure wherever you are, it's the perfect temperature for making some hilarious jokes! Let's get started, shall we?"
iex> Groq.Conversation.say(con, "that was not as funny as i hoped...")
"Oh, I'm sorry to hear that! Let me try again. Why don't we just leave meteorology to the weatherman and focus on what I'm best at - delivering jokes so cheesy, they'll make you laugh and groan at the same time!\n\nWhy don't scientists trust atoms?\n\nBecause they make up everything! (Don't worry, I'll work on my delivery 😄)"
```

```elixir
iex> Groq.SentimentAnalysisExample.analyze("You may say I'm a dreamer, but I'm not the only one. I hope someday you'll join us. And the world will live as one.")
%{
  clickbait: 0,
  uplifting: 0.9,
  informative: 0.1,
  interesting: 0.6,
  harmful: 0
}
```

## Installation

The package can be installed by adding `groq` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:groq, github: "pguillory/groq-elixir"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/groq>.

