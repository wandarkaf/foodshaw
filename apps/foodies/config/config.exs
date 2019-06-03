# Since configuration is shared in umbrella projects, this file
# should only configure the :foodies application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :foodies,
  ecto_repos: [Foodies.Repo]

import_config "#{Mix.env()}.exs"
