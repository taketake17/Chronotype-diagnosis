require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  let(:user) { User.create!(email: "test@example.com", password: "password", username: "テストユーザー") }
  let!(:chronotype) { Chronotype.create!(name: "クマ型") }
  let!(:chronotype1) { UserChronotype.create!(user: user, chronotype: chronotype, score: 10, created_at: 1.day.ago) }
  let!(:chronotype2) { UserChronotype.create!(user: user, chronotype: chronotype, score: 20, created_at: Time.zone.now) }

  describe "GET /users/:id" do
    it "ユーザー詳細ページが表示される" do
      get user_path(user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("テストユーザー")
    end

    it "最新のクロノタイプがセットされる" do
      get user_path(user)
      expect(response.body).to include("クマ型") # viewで@latest_chronotype.name等を表示している場合
    end
  end
end
