require 'capybara/rspec'
require 'selenium-webdriver'
require 'rails_helper'

RSpec.describe Consultation, type: :model do

  it 'has a title' do
    consultations = Consultation.new(
        title: '', 
        description:'has a description',
        start_time:'2023-03-06T10:30:00+00:00',
        end_time:'2024-03-06T10:30:00+00:00',
        code: 178632
    )
    expect(consultations).to_not be_valid
    consultations.title = "has a title"
    expect(consultations).to be_valid 
  end

  it 'has a description' do
    consultation = Consultation.new(
      title: 'has a title', 
      description: '',
      start_time: DateTime.new(2012, 12, 17),
      end_time: DateTime.new(2013, 12, 17),
      code: 178632
    )
    expect(consultation).to_not be_valid
    consultation.description = 'has a description'
    expect(consultation).to be_valid 
  end

  it 'has a start date' do
    consultation = Consultation.new(
      title: 'has a start date', 
      description: 'has a description',
      start_time: nil,
      end_time: DateTime.new(2013, 12, 17),
      code: 178632
    )
    expect(consultation).to_not be_valid
    consultation.start_time = DateTime.new(2012, 12, 17)
    expect(consultation).to be_valid 
  end

  it 'has a end date' do
    consultation = Consultation.new(
      title: 'has a title', 
      description: 'has a description',
      start_time:DateTime.new(2013, 12, 17),
      end_time: nil,
      code: 178632
    )
    expect(consultation).to_not be_valid
    consultation.end_time = DateTime.new(2012, 12, 17)
    expect(consultation).to be_valid 
  end

  it 'has a code' do
    consultation = Consultation.new(
      title: 'has a title', 
      description: 'has a description',
      start_time:DateTime.new(2013, 12, 17),
      end_time: DateTime.new(2013, 12, 17),
    )
    expect(consultation).to_not be_valid
    consultation.code = 178632
    expect(consultation).to be_valid 
  end

end
