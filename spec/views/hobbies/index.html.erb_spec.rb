require 'rails_helper'

RSpec.describe "hobbies/index", type: :view do
  before(:each) do
    assign(:hobbies, [
      Hobby.create!(
        name: "Name"
      ),
      Hobby.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of hobbies" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
