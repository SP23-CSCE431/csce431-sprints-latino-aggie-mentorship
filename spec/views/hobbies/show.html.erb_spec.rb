require 'rails_helper'

RSpec.describe "hobbies/show", type: :view do
  before(:each) do
    @hobby = assign(:hobby, Hobby.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
