class CoinMarketCapWrapper::CurrencyListing
  require 'httparty'
  class << self
    def init_data
      url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
      response = HTTParty.get(url, headers: {'X-CMC_PRO_API_KEY' => ENV["API_KEY"]})
      JSON.parse(response.body)
    end
    def save_data_in_redis
      init_data['data'].each do |currency|
        REDIS.set(currency['symbol'], currency.to_json)
      end
    end
  end
end
