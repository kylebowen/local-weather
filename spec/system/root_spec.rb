require "rails_helper"

RSpec.describe "root", type: :system do
  it "loads the app home page" do
    visit root_path

    expect(page).to have_text("Local Weather")
    expect(page).to have_field(placeholder: /Search for Address, City, or Zip Code/)
    expect(page).to have_button(:search)
  end
end
