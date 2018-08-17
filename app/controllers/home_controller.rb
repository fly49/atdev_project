class HomeController < ApplicationController
  def index
    
  end

  def history
    list = Convert.all
    @result = list.sort_by { |i| i.created_at }.reverse[0...9]
  end

  def convert
    CoinMarketCapWrapper::CurrencyConvert.convert(currency_from, currency_to, currency_given)
  end
end
