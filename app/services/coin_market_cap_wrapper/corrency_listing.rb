class CoinMarketCapWrapper::CurrencyListing
  require 'redis'

  class << self
    def init_data
      uri = URI('https://api.coinmarketcap.com/v2/listings/')
      responce = Net::HTTP.get(uri)
      JSON.parse(responce)
    end
    def save_data_in_redis
      redis = Redis.new(url: 'redis://localhost:32768/1')
      init_data['data'].each do |currency|
        redis.set(currency['name'], currency)
      end
    end
  end
end