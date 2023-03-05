# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe "Creating a User", type: :feature do
  scenario "with valid inputs" do
    visit new_user_path
    fill_in 'Name', with: 'John Smith'
    fill_in 'Status', with: 'Mentee'
    fill_in 'Year', with: 2023
    click_button "Create User"
    expect(page).to have_content("John Smith")
  end
end
