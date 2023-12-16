# Contains all env lookups in a single class for easy reference
#
# All ENV access should be done using ".fetch".
# Doing this without a fallback set will cause the deploy
# to fail if a required key is missing. (which is good!)
class AppSettings
  def self.geocoder_api_key
    ENV.fetch("GEOAPIFY_API_KEY")
  end
end
