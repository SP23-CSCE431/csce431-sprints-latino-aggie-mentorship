require 'rails_helper'

RSpec.describe Mentor, type: :model do
  it "requires mentor_name to be a string and hours to be an integer" do
    visit new_mentor_path

    # Fill in the form with valid data types
    fill_in "post_user_name", with: "John Doe"
    fill_in "post_hours", with: 10

    click_button "Update hours"

    # Checks if the form is submitted successfully
    expect(Mentor.last.hours).to eq(10)

    # Fill in the form with invalid data types
    fill_in "post_user_name", with: 123
    fill_in "post_hours", with: "abc"

    click_button "Update hours"

    # Expect an error message for the invalid data types
    expect(page).to have_content("User name must be a string")
    expect(page).to have_content("Hours must be an integer")
  end
end
