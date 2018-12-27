class CoinMarketCapWrapper::CurrencyConvert
  require 'httparty'
  class << self
    def convert(currency_from, currency_to, currency_give)
      data_from = JSON.parse(REDIS.get(currency_from))
      ratio = nil
      if currency_to == 'USD'
        ratio = to_price(data_from)
      else
        data_to = JSON.parse(REDIS.get(currency_to))
        ratio = exchange_rate(data_from, data_to)
      end
      Convert.create(currency_from: currency_from,
                     currency_to: currency_to,
                     currency_give: currency_give,
                     currency_take: count(ratio, currency_give.to_i),
                     exchange_rates: ratio)
    end
                    
    private
                    
    def count(exchange_rate, given_currency)
      exchange_rate * given_currency
    end
    
    def exchange_rate(data_from, data_to)
      to_price(data_from) / to_price(data_to)
    end
    
    def to_price(data)
      data.dig('quote','USD','price')
    end
  end
end