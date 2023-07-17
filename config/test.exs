import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :frostmount, FrostmountWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "/haqZH1I2jJ2aOs+9Vu2hwGpCEBzJav/pVOERBly0mbtQYywxIBd4wBhTMVM0R5W",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
