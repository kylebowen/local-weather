# Contains all env lookups in a single class for easy reference
#
# All ENV access should be done using ".fetch".
# Doing this without a fallback set will cause the deploy
# to fail if a required key is missing. (which is good!)
class AppSettings
  def self.geocoder_api_key
    ENV.fetch("GEOCODER_API_KEY")
  end

  def self.open_weather_api_key
    ENV.fetch("OPEN_WEATHER_API_KEY")
  end
end
