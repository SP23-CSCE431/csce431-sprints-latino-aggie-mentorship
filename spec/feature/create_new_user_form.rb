require 'rails_helper'
require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  # config.before(:each) do
  #   Capybara.current_driver = :selenium_chrome_headless
  #   Capybara.server_host = 'localhost'
  #   Capybara.server_port = '3000'
  #   Capybara.app_host = "http://localhost:#{Capybara.server_port}"

  #   # Sign in to Google OAuth
  #   visit '/users/auth/google_oauth2'
  #   fill_in 'Email', with: 'connie.liu@tamu.edu'
  #   click_button 'Next'
  #   fill_in 'Password', with: 'Cliu704087!!!!'
  #   click_button 'Next'

  #   # Wait for the page to load
  #   expect(page).to have_current_path('/')

  #   # Reset session
  #   Capybara.reset_sessions!
  # end

  # config.after(:each) do
  #   Capybara.use_default_driver
  # end
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
    role = "admin"
    OmniAuth.config.mock_auth[:google_oauth2]['info']['email'] = email
    visit new_admin_session_path
    click_button "Sign in with Google"
  end

  config.define_derived_metadata(:scenario) do |metadata|
    metadata[:type] = :feature
  end

  # scenario "Can sign in with Google OAuth" do
  #   email = "connie.liu@tamu.edu"
  #   role = "admin"
  #   OmniAuth.config.mock_auth[:google_oauth2]['info']['email'] = email
  #   visit new_admin_session_path
  #   click_button "Sign in with Google"
  #   expect(page).to have_content("Successfully authenticated from Google account.")
  #   expect(page).to have_content("You're logged in! Welcome to the Admin Dashboard!")
  #   expect(Admin.find_by(email: email, role: role)).not_to be_nil
  # end
end

RSpec.feature "Create new user form", type: :feature do
  scenario "Create new user path works" do
    visit new_user_path
    expect(page).to have_content("New user")
  end
end
# describe "User session login works" do
#   it "Signs in with Google OAuth2" do
#     email = "connie.liu@tamu.edu"
#     role = nil
#     OmniAuth.config.mock_auth[:google_oauth2]['info']['email'] = email
#     visit new_admin_session_path
#     click_button "Sign in with Google"
#     expect(page).to have_content("Successfully authenticated from Google account.")
#     expect(Admin.find_by(email: email, role: role)).not_to be_nil
#   end
# end

# describe "New user path works" do
#   it "Visits new user path" do
#     visit new_user_path
#     sleep 1
#     expect(page).to have_content("New user")
#   end
# end

# describe "User creates a new user with valid inputs" do
#   visit new_user_path
#   sleep 1
  
#   # Fill in form fields
#   fill_in "user_first_name", with: "John"
#   fill_in "user_last_name", with: "Doe"
#   fill_in "user_email", with: "johndoe@tamu.edu"
#   select "Mentor", from: "user_role"
#   select "Senior", from: "user_year"
  
#   click_button "Create User"
  
#   # Expect to be redirected to the user's show page
#   expect(page).to have_current_path(user_path(User.last))
  
#   # Expect success message to be displayed
#   expect(page).to have_content("User was successfully created.")
  
#   # Expect user's details to be displayed on the show page
#   expect(page).to have_content("John Doe")
#   expect(page).to have_content("johndoe@tamu.edu")
#   expect(page).to have_content("Mentor")
#   expect(page).to have_content("Senior")
# end

# describe "User tries to create a new user with invalid inputs" do
#   visit new_user_path
#   sleep 1
  
#   # Fill in form fields with invalid inputs
#   fill_in "user_first_name", with: ""
#   fill_in "user_last_name", with: ""
#   fill_in "user_email", with: "johndoe@gmail.com"
#   select "Mentor", from: "user_role"
#   select "Senior", from: "user_year"
  
#   click_button "Create User"
  
#   # Expect to see validation errors displayed
#   expect(page).to have_content("First name can't be blank")
#   expect(page).to have_content("Last name can't be blank")
#   expect(page).to have_content("Email must be a valid TAMU email address")
# end
