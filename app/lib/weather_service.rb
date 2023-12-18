class WeatherService
  class ForecastUnavailableError < StandardError
    def initialize(msg = "Weather forcast unavailable. Please try again later.")
      super(msg)
    end
  end

  def self.current_weather(...)
    new(...).current_weather
  end

  def initialize(query:, lang: :en, units: :imperial)
    @query = query
    @lang = lang
    @units = units
    @client = ::WeatherServiceClient.instance
  end

  def current_weather
    @location = ::Geocoder.search(query).first
    cached = true

    weather = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      cached = false
      lat, lon = location.coordinates
      client.current_weather(lat:, lon:, lang:, units:)
    end
    # TODO: combine into a single PORO
    [cached, location, weather]
  rescue StandardError => e
    Rails.logger.error { e }
    raise ForecastUnavailableError
  end

  private

  attr_reader :client, :lang, :location, :query, :units

  def cache_key
    "open_weather:current_weather:#{location.country}:#{location.postal_code}:#{location.city}"
  end
end
