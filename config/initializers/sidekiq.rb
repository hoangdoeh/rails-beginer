Sidekiq.configure_server do |config|
  config.redis = { url:  ENV.fetch("SIDEKIQ_REDIS_CONNECTION") { "redis://:secret_redis@localhost:6379/6" } }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("SIDEKIQ_REDIS_CONNECTION") { "redis://:secret_redis@localhost:6379/6" } }
end

Sidekiq::Cron::Job.create(
  name: "Create daily admin todo",
  cron: "0 6 * * *", # ví dụ chạy lúc 6h sáng mỗi ngày
  class: "TodoJobs::CreateTodoForAdmin"
)
