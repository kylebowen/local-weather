require "rails_helper"

RSpec.describe "/", type: :request do
  it "loads the app without errors" do
    get "/"

    expect(response).to have_http_status(:ok)
  end
end
