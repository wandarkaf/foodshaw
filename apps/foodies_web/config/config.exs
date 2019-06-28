# Since configuration is shared in umbrella projects, this file
# should only configure the :foodies_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :foodies_web,
  ecto_repos: [Foodies.Repo],
  generators: [context_app: :foodies]

# Configures the endpoint
config :foodies_web, FoodiesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ECMVb4r1x2v+iK6dP2r75vWDilbv4JcNUQcTlxtrvxr2AKOUpUu54TJpnRtlMVn6",
  render_errors: [view: FoodiesWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: FoodiesWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configuration related to apps that have access to viaa CORS
config :cors_plug,
  origin: ["http://localhost:3000"],
  max_age: 86400,
  methods: ["GET", "POST"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
