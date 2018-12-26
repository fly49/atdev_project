class UpdateCurrencyWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    CoinMarketCapWrapper::CurrencyListing.save_data_in_redis
    list_of_key = REDIS.keys
    list_of_key.each do |key|
      coin_data = CoinMarketCapWrapper::CurrencyInfo.get_data(key)['data']
      if coin_data
        REDIS.set(key, coin_data['quotes']['USD']['price'])
      end
    end
  end
end
