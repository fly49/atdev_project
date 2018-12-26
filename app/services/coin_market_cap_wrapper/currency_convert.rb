class CoinMarketCapWrapper::CurrencyConvert
  require 'httparty'
  class << self
    def convert(currency_from, currency_to, currency_give)
      data_from = REDIS.get(currency_from).scan(/\d/).to_s.delete('[]\, "').to_i
      data_to = REDIS.get(currency_to).scan(/[A-Z]{3,}/).first
      url = "https://api.coinmarketcap.com/v2/ticker/#{ data_from }/?convert=#{data_to}"
      response = HTTParty.get(url, headers: {'X-CMC_PRO_API_KEY' => ENV["API_KEY"]})
      result = JSON.parse(response.body)['data']
      prise = exchange_rates(result, data_to)
      Convert.create(currency_from: currency_from,
                     currency_to: currency_to,
                     currency_give: currency_give,
                     currency_take: count(prise, currency_give),
                     exchange_rates: prise)
    end
                    
    private
                    
    def count(exchange_rate, given_currency)
      given_currency * exchange_rate
    end

    def exchange_rates(result, data_to)
      result['quotes'].values_at(data_to).first['price']
    end
  end
end