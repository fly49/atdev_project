class HomeController < ApplicationController
  def index
  end
  
  def convert
    currency_from, currency_to, currency_give = permitted_params.values
    CoinMarketCapWrapper::CurrencyConvert.convert(currency_from, currency_to, currency_give)
  end

  def history
    @result = Covert.order(created_at: :desc)
  end
  
  def permitted_params
    params.permit(:from, :to, :given)
  end
end
