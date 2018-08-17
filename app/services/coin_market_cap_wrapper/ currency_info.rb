class CoinMarketCapWrapper::CurrencyInfo
  require 'json'
  require 'net/http'
  class << self
    def get_data(currency_name)
      redis = Redis.new(url: 'redis://localhost:32768/1')
      data = redis.get(currency_name).scan(/\d/).to_s.delete('[]\, "').to_i
      uri = URI("https://api.coinmarketcap.com/v2/ticker/#{ data }/")
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  end
end
