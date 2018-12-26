class CoinMarketCapWrapper::CurrencyListing
  require 'httparty'
  class << self
    def init_data
      url = 'https://api.coinmarketcap.com/v2/listings/'
      response = HTTParty.get(url, headers: {'X-CMC_PRO_API_KEY' => ENV["API_KEY"]})
      JSON.parse(response.body)
    end
    def save_data_in_redis
      init_data['data'].each do |currency|
        REDIS.set(currency['name'], currency)
      end
    end
  end
end
