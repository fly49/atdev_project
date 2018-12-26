Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq::Cron::Job.create(name: 'UpdateCurrencyWorker - every 5min', cron: '*/5 * * * *', class: 'UpdateCurrencyWorker')
