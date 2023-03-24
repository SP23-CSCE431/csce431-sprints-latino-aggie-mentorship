require 'rails_helper'

RSpec.feature "Create new user", type: :feature do
  scenario "User creates a new user with valid inputs" do
    visit "/users/new"
    
    # Fill in form fields
    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Doe"
    fill_in "Email", with: "johndoe@tamu.edu"
    select "Mentor", from: "Role"
    select "Senior", from: "Year"
    
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
    fill_in "First Name", with: ""
    fill_in "Last Name", with: ""
    fill_in "Email", with: "johndoe@gmail.com"
    select "Mentor", from: "Role"
    select "Senior", from: "Year"
    
    click_button "Create User"
    
    # Expect to see validation errors displayed
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email must be a valid TAMU email address")
  end
end
