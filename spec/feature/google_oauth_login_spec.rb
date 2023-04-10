# require 'rails_helper'
require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.feature "Google OAuth authentication", type: :feature do
  let(:admin_email) { 'connie.liu@tamu.edu' }
  let(:mentor_email) { 'r_alzubaidi@tamu.edu' }
  let(:mentee_email) { 'michaelswim@tamu.edu' }
  let(:guest_email) { 'kyleblanco@tamu.edu' }

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      'provider' => 'google_oauth2',
      'uid' => '123456789',
      'info' => {
        'email' => 'test@example.com'
      },
      'credentials' => {
        'token' => 'token',
        'expires_at' => Time.now
      }
    })
  end

  scenario "Admin can sign in with Google OAuth" do
    email = admin_email
    role = "Admin"
    OmniAuth.config.mock_auth[:google_oauth2]['info']['email'] = email
    visit new_admin_session_path
    click_button "Sign in with Google"
    expect(page).to have_content("Successfully authenticated from Google account.")
    expect(Admin.find_by(email: email, role: role)).not_to be_nil
  end

  scenario "Mentor can sign in with Google OAuth" do
    email = mentor_email
    role = "Mentor"
    OmniAuth.config.mock_auth[:google_oauth2]['info']['email'] = email
    visit new_admin_session_path
    click_button "Sign in with Google"
    expect(page).to have_content("Successfully authenticated from Google account.")
    expect(Admin.find_by(email: email, role: role)).not_to be_nil
  end

  scenario "Mentee can sign in with Google OAuth" do
    email = mentee_email
    role = "Mentee"
    OmniAuth.config.mock_auth[:google_oauth2]['info']['email'] = email
    visit new_admin_session_path
    click_button "Sign in with Google"
    expect(page).to have_content("Successfully authenticated from Google account.")
    expect(Admin.find_by(email: email, role: role)).not_to be_nil
  end

  scenario "Guest can sign in with Google OAuth" do
    email = guest_email
    role = nil
    OmniAuth.config.mock_auth[:google_oauth2]['info']['email'] = email
    visit new_admin_session_path
    click_button "Sign in with Google"
    expect(page).to have_content("Successfully authenticated from Google account.")
    expect(Admin.find_by(email: email, role: role)).not_to be_nil
  end
end
