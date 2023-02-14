# location: spec/unit/unit_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(name: 'john smith', status: 'member', year: '2023')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    subject.status = nil
    subject.year = nil
    expect(subject).not_to be_valid
  end
end