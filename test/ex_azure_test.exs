defmodule ExAzureTest do
  use ExUnit.Case

  @module ExAzure

  test "ensure that all services way started" do
    assert :ok == Application.ensure_started(:ex_azure)
    assert :ok == Application.ensure_started(:erlazure)
  end

  @tag external: true
  @tag timeout: 15000
  describe "send actions to :erlazure" do
    test "request/3 should response" do
      {status, response} = @module.request(:list_containers, [])
      assert status == :ok
      assert is_list(response[:body])
      assert is_list(response[:headers])

      {status, response} = @module.request(:list_blobs, ["uploads"])
      assert status == :ok
      assert is_list(response[:body])
      assert is_list(response[:headers])

      {status, response} = @module.request(:list_blobs, [])
      assert status == :error
      assert response.__struct__ == UndefinedFunctionError
    end

    test "request!/3 should response or raised error" do
      response = @module.request!(:list_containers)
      assert is_list(response[:body])
      assert is_list(response[:headers])

      response = @module.request!(:list_blobs, ["uploads"])
      assert is_list(response[:body])
      assert is_list(response[:headers])

      assert_raise UndefinedFunctionError, fn ->
        @module.request!(:list_blobs, [])
      end
    end
  end

end
