class WeatherService
  class ForecastUnavailableError < StandardError
    def initialize(msg = "Weather forcast unavailable. Please try again later.")
      super(msg)
    end
  end

  attr_accessor :client

  def self.current_weather(search:, lang: :en, units: :imperial)
    location = ::Geocoder.search(search).first
    lat, lon = location.coordinates

    cached = true
    cache_key = "open_weather:current_weather:#{location.postal_code}"
    weather = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      cached = false
      new.client.current_weather(lat:, lon:, lang:, units:)
    end
    # TODO: combine into a single PORO
    [cached, location, weather]
  rescue StandardError => e
    Rails.logger.error { e }
    raise ForecastUnavailableError
  end

  def initialize
    @client = ::WeatherServiceClient.instance.open_weather
  end
end
