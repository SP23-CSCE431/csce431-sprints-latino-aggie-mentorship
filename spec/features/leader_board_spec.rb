require 'rails_helper'
RSpec.describe LeaderBoardController, type: :controller do
    describe "GET index" do
      it "assigns @ranking" do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user)
        # Create some hours for each user
        FactoryBot.create(:hour, user: user1, hours: true)
        FactoryBot.create(:hour, user: user1, hours: true)
        FactoryBot.create(:hour, user: user2, hours: true)
        #call index action and check that the @ranking variable is assigned correctly.
        get :index
        expect(assigns(:ranking)).to eq([[user2, 1], [user1, 2]])
      end
      # check that the correct view template is rendered
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end
  end