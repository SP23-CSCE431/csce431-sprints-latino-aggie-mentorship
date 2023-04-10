require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  describe "ranker" do
    it "returns an empty array if there are no mentors" do
      expect(controller.send(:ranker)).to eq([])
    end
    
    it "returns an empty array if there are no mentors" do
      expect(controller.send(:ranker)).to eq([])
    end

  end

end
