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

RSpec.feature "Create new user", type: :feature do
  scenario "User creates a new user with valid inputs" do
    visit "/users/new"
    
    # Fill in form fields
    fill_in "user_first_name", with: "John"
    fill_in "user_last_name", with: "Doe"
    fill_in "user_email", with: "johndoe@tamu.edu"
    select "Mentor", from: "user_role"
    select "Senior", from: "user_year"
    
    click_button "Create User"
    
    # Expect to be redirected to the user's show page
    expect(page).to have_current_path(user_path(User.last))
    
    # Expect success message to be displayed
    expect(page).to have_content("User was successfully created.")
    
    # Expect user's details to be displayed on the show page
    expect(page).to have_content("John Doe")
    expect(page).to have_content("johndoe@tamu.edu")
    expect(page).to have_content("Mentor")
    expect(page).to have_content("Senior")
  end
  
  scenario "User tries to create a new user with invalid inputs" do
    visit "/users/new"
    
    # Fill in form fields with invalid inputs
    fill_in "user_first_name", with: ""
    fill_in "user_last_name", with: ""
    fill_in "user_email", with: "johndoe@gmail.com"
    select "Mentor", from: "user_role"
    select "Senior", from: "user_year"
    
    click_button "Create User"
    
    # Expect to see validation errors displayed
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end
end
