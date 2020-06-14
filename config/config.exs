# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bkmarkus,
  ecto_repos: [Bkmarkus.Repo]

# Configures the endpoint
config :bkmarkus, BkmarkusWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sIzd5TyO72HLgIkaNRZvt0/E51Z86yoU+nlzFZDO5jGvvMfzNEBtH+vulJMeAf8P",
  render_errors: [view: BkmarkusWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Bkmarkus.PubSub,
  live_view: [signing_salt: "yDLDFbyb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
