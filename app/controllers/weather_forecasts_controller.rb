class WeatherForecastsController < ApplicationController
  before_action :set_session_search

  def index
    if session[:search].present?
      cached, location, weather_data = ::WeatherService.current_weather(search: session[:search])
      render(:index, locals: { cached:, location:, weather_data:, error: nil })
    else
      redirect_to(new_weather_forecast_path)
    end
  rescue StandardError => e
    Rails.logger.error { e }
    # TODO: Maybe instead of rendering a whole new page,
    #       we do a toast and stay on the same page?
    render(:index, locals: { cached:, location:, weather_data: , error: e })
  end

  private

  def set_session_search
    session[:search] = params[:search].presence || session[:search]
  end
end
