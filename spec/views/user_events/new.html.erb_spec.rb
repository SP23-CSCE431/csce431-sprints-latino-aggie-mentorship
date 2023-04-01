require 'rails_helper'

RSpec.describe "user_events/new", type: :view do
  before(:each) do
    assign(:user_event, UserEvent.new(
      user_id: 1,
      consultation_id: 1
    ))
  end

  it "renders new user_event form" do
    render

    assert_select "form[action=?][method=?]", user_events_path, "post" do

      assert_select "input[name=?]", "user_event[user_id]"

      assert_select "input[name=?]", "user_event[consultation_id]"
    end
  end
end
