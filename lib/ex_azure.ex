defmodule ExAzure do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    account    = Application.get_env(:ex_azure, :account)
    access_key = Application.get_env(:ex_azure, :access_key)

    IO.inspect [account: account, access_key: access_key]

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: ExAzure.Worker.start_link(arg1, arg2, arg3)
      # worker(ExAzure.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExAzure.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def stop(_state) do
    :ok
  end
end
