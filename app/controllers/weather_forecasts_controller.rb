class WeatherForecastsController < ApplicationController
  before_action :set_session_location

  def index
    # get weather forecast via open-weather-ruby-client
    weather_data = ::WeatherService.current_weather(location:)
    render(:index, locals: { location:, weather_data: })
  end

  private

  def location
    @location ||= ::Geocoder.search(search_terms).first
  end

  def search_terms
    session[:location] || default_coordinates
  end

  def default_coordinates
    ::WeatherService::DEFAULT_LOCATION.coordinates
  end

  def set_session_location
    session[:location] =  params[:location].present? ? params[:location] : session[:location]
  end
end
