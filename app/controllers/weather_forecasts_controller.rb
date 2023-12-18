class WeatherForecastsController < ApplicationController
  before_action :set_session_query

  def new
  end

  def index
    if session[:query].present?
      cached, location, weather_data = ::WeatherService.current_weather(query: session[:query])
      render(:index, locals: { cached:, location:, weather_data: })
    else
      redirect_to(new_weather_forecast_path)
    end
  rescue StandardError => e
    Rails.logger.error { e }
    # TODO: Use Hotwire/Turbo to display an error toast without needing a re-render.
    render(new_weather_forecast_path)
  end

  private

  def set_session_query
    session[:query] = params[:query].presence || session[:query]
  end
end
