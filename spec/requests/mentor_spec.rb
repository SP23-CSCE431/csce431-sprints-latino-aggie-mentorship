require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/mentor/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/mentor/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/mentor/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/mentor/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
