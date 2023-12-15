require "rails_helper"

RSpec.describe "/", type: :request do
  it "loads the app home page" do
    get "/"
    expect(response).to have_http_status(:ok)
  end
end
