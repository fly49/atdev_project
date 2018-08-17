class UpdateCurrencyWorker
  include Sidekiq::Worker

  def perform
    redis = Redis.new(url: 'redis://localhost:32768/1')
    value_redis = Redis.new(url: 'redis://localhost:32768/2')
    list_of_key = redis.keys
    list_of_key.each do |key|
      if CoinMarketCapWrapper::CurrencyInfo.get_data(key)['data'] != nil
        cost = CoinMarketCapWrapper::CurrencyInfo.get_data(key)['data']['quotes']
      end
      cost.compact
      value_redis.set(key, cost['USD']['price'])
    end
  end
  UpdateCurrencyWorker.perform_at(5.minute)
end
