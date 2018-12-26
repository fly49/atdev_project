class HomeController < ApplicationController
  def index
  end
  
  def convert
    currency_from, currency_to, currency_give = permitted_params.values
    @convert = CoinMarketCapWrapper::CurrencyConvert.convert(currency_from, currency_to, currency_give)
    render json: @convert
  end

  def history
    @result = Convert.order(created_at: :desc)
    render json: @result
  end
  
  def permitted_params
    params.permit(:from, :to, :given)
  end
end
