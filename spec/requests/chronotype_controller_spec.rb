require 'rails_helper'

RSpec.describe "ChronotypeController", type: :request do
  before do
    Chronotype.create!(id: 1, name: "イルカ型")
    Chronotype.create!(id: 2, name: "ライオン型")
    Chronotype.create!(id: 3, name: "クマ型")
    Chronotype.create!(id: 4, name: "オオカミ型")
  end

  describe "GET /chronotype/summary/dolphin" do
    it "200が返る" do
      get "/chronotype/summary/dolphin"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /chronotype/summary/lion" do
    it "200が返る" do
      get "/chronotype/summary/lion"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /chronotype/summary/bear" do
    it "200が返る" do
      get "/chronotype/summary/bear"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /chronotype/summary/wolf" do
    it "200が返る" do
      get "/chronotype/summary/wolf"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /chronotype/details/bear" do
    it "200が返る" do
      get "/chronotype/details/bear"
      expect(response).to have_http_status(:ok)
    end
  end
end
