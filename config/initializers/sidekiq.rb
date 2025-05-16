Sidekiq.configure_server do |config|
  config.redis = { url:  ENV.fetch("SIDEKIQ_REDIS_CONNECTION") { "redis://:secret_redis@localhost:6379/6" } }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://:secret_redis@localhost:6379/6" }
end
