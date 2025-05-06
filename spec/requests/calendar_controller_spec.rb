# require 'rails_helper'

# RSpec.describe "CalendarController", type: :request do
#   # 必要ならFactoryBotを使ってもOK
#   let(:user) { User.create!(email: "test@example.com", password: "password", username: "テストユーザー") }

#   before do
#     # 認証・クロノタイプバイパス
#     allow_any_instance_of(CalendarController).to receive(:authenticate_user!).and_return(true)
#     allow_any_instance_of(ApplicationController).to receive(:check_chronotype).and_return(true)
#     allow_any_instance_of(CalendarController).to receive(:current_user).and_return(user)
#     # クロノタイプ関連が必須なら下記を追加
#     # chronotype = Chronotype.create!(name: "クマ型")
#     # UserChronotype.create!(user: user, chronotype: chronotype, score: 10)
#   end

#   describe "GET /calendar" do
#     it "ページが表示される" do
#       get calendar_index_path
#       expect(response).to have_http_status(:ok)
#     end
#   end

#   describe "POST /calendar" do
#     it "予定を作成できる" do
#       post calendar_index_path, params: {
#         schedule: {
#           title: "テスト予定",
#           start_time: Time.zone.now,
#           end_time: Time.zone.now + 1.hour,
#           content: "テスト内容"
#         }
#       }, as: :json
#       expect(response).to have_http_status(:created)
#       expect(JSON.parse(response.body)["status"]).to eq("success")
#     end
#   end

#   describe "PATCH /calendar/:id" do
#     it "予定を更新できる" do
#       schedule = Schedule.create!(
#         user: user,
#         title: "元の予定",
#         start_time: Time.zone.now,
#         end_time: Time.zone.now + 1.hour,
#         content: "元の内容"
#       )
#       patch calendar_path(schedule.id), params: {
#         schedule: { title: "更新後タイトル" }
#       }, as: :json
#       expect(response).to have_http_status(:ok)
#       expect(JSON.parse(response.body)["status"]).to eq("success")
#       expect(schedule.reload.title).to eq("更新後タイトル")
#     end
#   end

#   describe "DELETE /calendar/:id" do
#     it "予定を削除できる" do
#       schedule = Schedule.create!(
#         user: user,
#         title: "削除予定",
#         start_time: Time.zone.now,
#         end_time: Time.zone.now + 1.hour,
#         content: "削除内容"
#       )
#       expect {
#         delete calendar_path(schedule.id), as: :json
#       }.to change(Schedule, :count).by(-1)
#       expect(response).to have_http_status(:ok)
#       expect(JSON.parse(response.body)["status"]).to eq("success")
#     end
#   end
# end
