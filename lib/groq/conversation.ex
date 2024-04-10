defmodule Groq.Conversation do
  use GenServer

  defstruct [:model, :messages]

  def start_link(opts \\ []) do
    {gen_server_opts, opts} = Keyword.split(opts, [:name])
    GenServer.start_link(__MODULE__, opts, gen_server_opts)
  end

  def say(conversation, user_message, timeout \\ 5000) do
    GenServer.call(conversation, {:say, user_message}, timeout)
  end

  def stop(conversation) do
    GenServer.stop(conversation)
  end

  @roles ~w[system user assistant]

  defp add_message(%__MODULE__{} = state, role, content)
       when role in @roles and is_binary(content) do
    update_in(state.messages, fn messages ->
      messages ++ [%{role: role, content: content}]
    end)
  end

  defp get_system_prompt(%__MODULE__{} = state, opts) do
    case Keyword.fetch(opts, :system_prompt) do
      {:ok, system_prompt} when is_binary(system_prompt) ->
        add_message(state, "system", system_prompt)

      :error ->
        state
    end
  end

  def init(opts) do
    state = %__MODULE__{
      model: Keyword.get(opts, :model, Groq.default_model()),
      messages: []
    }

    state = get_system_prompt(state, opts)
    {:ok, state}
  end

  def handle_call({:say, user_message}, _, state) do
    state = add_message(state, "user", user_message)
    response = Groq.completions(model: state.model, messages: state.messages)
    %{"choices" => [choice]} = response
    %{"message" => %{"content" => assistant_message}} = choice
    state = add_message(state, "assistant", assistant_message)
    {:reply, assistant_message, state}
  end
end
