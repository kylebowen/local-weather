class WeatherForecastsController < ApplicationController
  before_action :set_session_location

  def index
    if params[:location].blank? && session[:location].present?
      redirect_to(weather_forecasts_url(location:)) and return
    else
      # get lat, long for location via geocoder
      # get weather forecast via open-weather-ruby-client
      render(:index, locals: { location: })
    end
  end

  private

  def location
    session[:location]
  end

  def set_session_location
    session[:location] =  params[:location].present? ? params[:location] : session[:location]
  end
end
