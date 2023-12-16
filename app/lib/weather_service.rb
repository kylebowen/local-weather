class WeatherService
  DEFAULT_LOCATION = OpenStruct.new(
    coordinates: [37.3229, -122.0323],
    lat: 37.3229,
    lon: -122.0323,
    postal_code: 95014,
  )

  attr_accessor :client

  def self.current_weather(location:, lang: :en, units: :imperial)
    lat, lon = location.coordinates
    lat ||= DEFAULT_LOCATION.lat
    lon ||= DEFAULT_LOCATION.lon
    new.client.current_weather(lat:, lon:, lang:, units:)
  end

  def initialize
    @client = ::WeatherServiceClient.instance.open_weather
  end
end
