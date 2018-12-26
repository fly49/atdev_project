class CoinMarketCapWrapper::CurrencyConvert
  require 'net/http'
  class << self
    def convert(currency_from, currency_to, currency_give)
      data_from = REDIS.get(currency_from).scan(/\d/).to_s.delete('[]\, "').to_i
      data_to = REDIS.get(currency_to).scan(/[A-Z]{3,}/).first
      uri = URI("https://api.coinmarketcap.com/v2/ticker/#{ data_from }/?convert=#{data_to}")
      response = Net::HTTP.get(uri)
      result = JSON.parse(response)['data']
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