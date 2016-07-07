defmodule ExAzure.ServerTest do
  use ExUnit.Case

  @module ExAzure.Server

  test "get config from state" do
    config = GenServer.call(@module, :config)

    assert config[:access_key] == Application.get_env(:ex_azure, :access_key)
    assert config[:account]    == Application.get_env(:ex_azure, :account)
  end

  test "get client pid from state" do
    assert Application.get_application(:erlazure) == :erlazure
    assert Application.ensure_started(:ex_azure) == :ok

    assert is_pid(GenServer.call(@module, :client))
  end
end
