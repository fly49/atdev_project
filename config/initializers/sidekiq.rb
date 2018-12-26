Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq::Cron::Job.create(name: 'UpdateCurrency - every 1 hour', cron: '0 */2 * * *', class: 'UpdateCurrencyWorker')
