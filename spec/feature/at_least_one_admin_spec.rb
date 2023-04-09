require 'rails_helper'
require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      'provider' => 'google_oauth2',
      'uid' => '123456789',
      'info' => {
        'email' => 'test@example.com'
      },
      'credentials' => {
        'token' => 'token',
        'expires_at' => Time.now + 1.week
      }
    })
    email = "connie.liu@tamu.edu"
    role = "Admin"
    OmniAuth.config.mock_auth[:google_oauth2]['info']['email'] = email
    visit new_admin_session_path
    click_button "Sign in with Google"
  end

  config.define_derived_metadata(:scenario) do |metadata|
    metadata[:type] = :feature
  end
end

RSpec.feature "Remove Single Admin", type: :feature do
  scenario "User tries to destroy single admin user" do
    visit "/users/new"
    
    # Fill in form fields
    fill_in "user_first_name", with: "Connie"
    fill_in "user_last_name", with: "Liu"
    fill_in "user_email", with: "connie.liu@tamu.edu"
    select "Admin", from: "user_role"
    select "Senior", from: "user_year"
    
    click_button "Create User"

    # Destroy the single admin user that was just created
    click_button "Destroy this user"

    # Expect error message to be displayed
    expect(page).to have_content("There must be at least one admin user.")
  end

  scenario "User tries to modify single admin user" do
    visit "/users/new"
    
    # Fill in form fields
    fill_in "user_first_name", with: "Connie"
    fill_in "user_last_name", with: "Liu"
    fill_in "user_email", with: "connie.liu@tamu.edu"
    select "Admin", from: "user_role"
    select "Senior", from: "user_year"
    
    click_button "Create User"

    # Edit the single admin user that was just created
    click_link "Edit this user"
    select "Mentor", from: "user_role"
    click_button "Update User"

    # Expect error message to be displayed
    expect(page).to have_content("There must be at least one admin user.")
  end
  
  scenario "User tries to modify one of multiple admin users" do
    visit "/users/new"
    
    # Fill in form fields
    fill_in "user_first_name", with: "Connie"
    fill_in "user_last_name", with: "Liu"
    fill_in "user_email", with: "connie.liu@tamu.edu"
    select "Admin", from: "user_role"
    select "Senior", from: "user_year"
    
    click_button "Create User"

    visit "/users/new"
    
    # Fill in form fields
    fill_in "user_first_name", with: "Mary"
    fill_in "user_last_name", with: "Jane"
    fill_in "user_email", with: "mj@tamu.edu"
    select "Admin", from: "user_role"
    select "Senior", from: "user_year"
    
    click_button "Create User"
    
    # Edit the second admin user the was just created
    click_link "Edit this user"
    select "Mentor", from: "user_role"
    click_button "Update User"

    # Expect to be redirected to the user's show page
    expect(page).to have_current_path(user_path(User.last))

    # Expect success message to be displayed
    expect(page).to have_content("User was successfully updated.")

    # Expect user's details to be displayed on the show page
    expect(page).to have_content("Mary Jane")
    expect(page).to have_content("mj@tamu.edu")
    expect(page).to have_content("Mentor")
    expect(page).to have_content("Senior")
  end
end
