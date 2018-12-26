class UpdateCurrencyWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    CoinMarketCapWrapper::CurrencyListing.save_data_in_redis
  end
end
