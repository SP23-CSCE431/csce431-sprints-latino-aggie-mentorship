require 'rails_helper'

RSpec.describe "user_events/show", type: :view do
  before(:each) do
    @user_event = assign(:user_event, UserEvent.create!(
      user_id: 2,
      consultation_id: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
