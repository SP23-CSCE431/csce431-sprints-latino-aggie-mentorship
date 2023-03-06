require "application_system_test_case"

class ConsulationsTest < ApplicationSystemTestCase
  setup do
    @consulation = consulations(:one)
  end

  test "visiting the index" do
    visit consulations_url
    assert_selector "h1", text: "Consulations"
  end

  test "should create consulation" do
    visit consulations_url
    click_on "New consulation"

    fill_in "Description", with: @consulation.description
    fill_in "End time", with: @consulation.end_time
    fill_in "Start time", with: @consulation.start_time
    fill_in "Title", with: @consulation.title
    click_on "Create Consulation"

    assert_text "Consulation was successfully created"
    click_on "Back"
  end

  test "should update Consulation" do
    visit consulation_url(@consulation)
    click_on "Edit this consulation", match: :first

    fill_in "Description", with: @consulation.description
    fill_in "End time", with: @consulation.end_time
    fill_in "Start time", with: @consulation.start_time
    fill_in "Title", with: @consulation.title
    click_on "Update Consulation"

    assert_text "Consulation was successfully updated"
    click_on "Back"
  end

  test "should destroy Consulation" do
    visit consulation_url(@consulation)
    click_on "Destroy this consulation", match: :first

    assert_text "Consulation was successfully destroyed"
  end
end
