require "rails_helper"

RSpec.describe "/", type: :request do
  context "when the user has no previous sessions or searches" do
    it "redirects to an appropriate page" do
      get "/"

      expect(response).to redirect_to(new_weather_forecast_path)

      follow_redirect!

      expect(response).to have_http_status(:ok)
    end
  end
end
