class CoinMarketCapWrapper::CurrencyInfo
  require 'httparty'
  class << self
    def get_data(currency_name)
      data = REDIS.get(currency_name).scan(/\d/).to_s.delete('[]\, "').to_i
      url = "https://api.coinmarketcap.com/v2/ticker/#{ data }/"
      response = HTTParty.get(url, headers: {'X-CMC_PRO_API_KEY' => ENV["API_KEY"]})
      JSON.parse(response.body)
    end
  end
end
