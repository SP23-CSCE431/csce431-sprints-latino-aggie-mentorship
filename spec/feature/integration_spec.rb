# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a user', type: :feature do
  scenario 'valid inputs' do
    visit new_user_path
    fill_in 'user[name]', with: "john smith"
    fill_in 'user[status]', with: "member"
    fill_in 'user[year]', with: 2023
    click_on 'Create User'
    visit user_path
    expect(page).to have_content('john smith')
  end
end