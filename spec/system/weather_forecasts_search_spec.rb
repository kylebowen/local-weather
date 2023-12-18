require "rails_helper"

RSpec.describe "searching for weather forecasts by location", type: :system do
  context "when the user has no previous sessions or searches" do
    it "redirects to an appropriate page" do
      visit root_path

      expect(page).to have_text("Please select a location")
    end
  end

  context "when the user searches " do
    it "uses the previous search to load weather data" do
      # Brand-new site visitor
      visit weather_forecasts_path

      # Sees `/new` template rendered with friendly instructions
      expect(page).to have_text("Please select a location")

      # Selects a location
      visit weather_forecasts_path(query: "Los Angeles, CA")

      # Does not get sent to the `/new` template this time
      expect(page).not_to have_text("Please")
      # Sees weather info related to their query!
      expect(page).to have_text("Los Angeles")
      expect(page).to have_text("Feels like")

      # Gets rid of those ugly query params in the url bar and refreshes the page
      visit weather_forecasts_path

      # Still does not get sent to the `/new` template!?!
      expect(page).not_to have_text("Please")

      # Sees weather info related to their previous query!
      expect(page).to have_text("Los Angeles")
      expect(page).to have_text("Feels like")
    end
  end
end
