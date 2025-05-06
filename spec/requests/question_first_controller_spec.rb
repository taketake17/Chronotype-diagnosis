require 'rails_helper'

RSpec.describe "QuestionFirstController", type: :request do
  let!(:questions) { create_list(:question, 10, part: 1) }
  let!(:dolphin) { create(:chronotype, name: "イルカ型") } # イルカ型Chronotypeを用意

  describe "GET /question_first" do
    it "正常にページが表示される" do
      get question_first_path(page: 1)
      expect(response).to have_http_status(:ok)
      questions[0..4].each do |q|
        expect(response.body).to include(q.question_text)
      end
      expect(response.body).to include("10")
      expect(response.body).to include("0%")
    end
  end

  describe "POST /question_first" do
    context "全ての質問に回答した場合" do
      it "次のページにリダイレクトされる" do
        post question_first_path(page: 1), params: {
          answers: questions[0..4].index_with { 1 }
        }
        expect(response).to redirect_to(question_first_path(page: 2))
      end
    end

    context "未回答の質問がある場合" do
      it "同じページにリダイレクトされアラートが表示される" do
        post question_first_path(page: 1), params: {
          answers: { questions.first.id => 1 }
        }
        expect(response).to redirect_to(question_first_path(page: 1))
        follow_redirect!
        expect(response.body).to include("全ての質問に回答してください。")
      end
    end
  end
end
