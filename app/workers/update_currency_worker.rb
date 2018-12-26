class UpdateCurrencyWorker
  include Sidekiq::Worker

  def perform
    list_of_key = REDIS.keys
    list_of_key.each do |key|
      if CoinMarketCapWrapper::CurrencyInfo.get_data(key)['data'] != nil
        cost = CoinMarketCapWrapper::CurrencyInfo.get_data(key)['data']['quotes']
      end
      cost.compact
      REDIS.set(key, cost['USD']['price'])
    end
  end
  UpdateCurrencyWorker.perform_at(5.minute)
end
