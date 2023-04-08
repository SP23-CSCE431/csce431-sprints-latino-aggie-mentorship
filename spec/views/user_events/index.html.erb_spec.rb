require 'rails_helper'

RSpec.describe "user_events/index", type: :view do
  before(:each) do
    assign(:user_events, [
      UserEvent.create!(
        user_id: 2,
        consultation_id: 3
      ),
      UserEvent.create!(
        user_id: 2,
        consultation_id: 3
      )
    ])
  end

  it "renders a list of user_events" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
