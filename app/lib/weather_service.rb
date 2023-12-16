class WeatherService
  attr_accessor :client

  def self.current_weather(lat:, lon:, lang: :en, units: :imperial)
    new.client.current_weather(lat:, lon:, lang:, units:)
  end

  def initialize
    @client = ::WeatherServiceClient.instance.open_weather
  end
end
