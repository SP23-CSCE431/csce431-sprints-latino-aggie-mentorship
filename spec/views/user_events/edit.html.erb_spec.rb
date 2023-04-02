require 'rails_helper'

RSpec.describe "user_events/edit", type: :view do
  before(:each) do
    @user_event = assign(:user_event, UserEvent.create!(
      user_id: 1,
      consultation_id: 1
    ))
  end

  it "renders the edit user_event form" do
    render

    assert_select "form[action=?][method=?]", user_event_path(@user_event), "post" do

      assert_select "input[name=?]", "user_event[user_id]"

      assert_select "input[name=?]", "user_event[consultation_id]"
    end
  end
end
