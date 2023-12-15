class LocationSearchesController < ApplicationController
  def create
    # search for the thing
    redirect_to weather_forecasts_path
  end
end
