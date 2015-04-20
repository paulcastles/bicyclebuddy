class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :get_weather
  
  
  def get_weather
    ForecastIO.api_key = 'dcc77887ea2f5b39677a047b61ebe8d3'
    @forecast = ForecastIO.forecast(53.347, -6.251, params: {units: 'ca'})
  end
end
