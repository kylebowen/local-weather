class WeatherServiceClient
  include Singleton

  def current_weather(...)
    open_weather.current_weather(...)
  end

  def open_weather
    @open_weather ||= ::OpenWeather::Client.new(api_key: ::AppSettings.open_weather_api_key)
  end
end
