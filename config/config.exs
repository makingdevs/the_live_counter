# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :the_live_counter, TheLiveCounterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "daI09FcnrbhnTapis/VCNj3Ci7pFp7/fn3MfLIxdgNsMsQV6sChD6GhbihKd29SN",
  render_errors: [view: TheLiveCounterWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TheLiveCounter.PubSub,
  live_view: [signing_salt: "W1vxyI6U"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
