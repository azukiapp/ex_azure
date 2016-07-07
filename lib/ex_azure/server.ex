defmodule ExAzure.Server do
  use GenServer

  def start_link(config \\ []) do
    GenServer.start_link(__MODULE__, config, name: __MODULE__)
  end

  def init(config \\ []) do
    config = ExAzure.defaults(config)

    account    = to_charlist(config[:account])
    access_key = to_charlist(config[:access_key])

    {:ok, client} = :erlazure.start(account, access_key)
    {:ok, [config: config, client: client]}
  end

  # Server handles
  #
  def handle_call(:config, _from, state) do
    {:reply, state[:config], state}
  end

  def handle_call(:client, _from, state) do
    {:reply, state[:client], state}
  end

  def handle_call({_action, _args} = request, from, state) do
    {:ok, :reply, {request, from, state}}
  end

end
