require "rails_helper"

RSpec.describe "root", type: :system do
  it "loads the app home page" do
    visit root_path

    expect(page).to have_text("Search your Address, City, or Zip Code")
    expect(page).to have_button("Search")
  end
end
