require 'rails_helper'

RSpec.feature "Google OAuth2 authentication", type: :feature do
  let(:admin_email) { 'connie.liu@tamu.edu' }
  let(:mentor_email) { 'spottedelefant@tamu.edu' }
  let(:mentee_email) { 'kyleblanco@tamu.edu' }

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
        'expires_at' => Time.now + 1.week
      }
    })
  end

  scenario "Admin can sign in with Google OAuth2" do
    email = admin_email
    visit new_user_session_path
    click_button "Sign in with Google"
    expect(page).to have_content("Successfully authenticated from Google account.")
    expect(page).to have_current_path(root_path)
    expect(Admin.find_by(email: email)).not_to be_nil
  end

  scenario "Mentor can sign in with Google OAuth2" do
    email = mentor_email
    role = "mentor"
    OmniAuth.config.mock_auth[:google_oauth2]['info']['email'] = email
    visit new_user_session_path
    click_button "Sign in with Google"
    expect(page).to have_content("Successfully authenticated from Google account.")
    expect(page).to have_current_path(root_path)
    expect(User.find_by(email: email, role: role)).not_to be_nil
  end

  scenario "Mentee can sign in with Google OAuth2" do
    email = mentee_email
    role = "mentee"
    OmniAuth.config.mock_auth[:google_oauth2]['info']['email'] = email
    visit new_user_session_path
    click_button "Sign in with Google"
    expect(page).to have_content("Successfully authenticated from Google account.")
    expect(page).to have_current_path(root_path)
    expect(User.find_by(email: email, role: role)).not_to be_nil
  end
end
