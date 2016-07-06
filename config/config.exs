use Mix.Config

config :ex_azure,
    account:    System.get_env("AZURE_ACCOUNT"),
    access_key: System.get_env("AZURE_ACCESS_KEY")
