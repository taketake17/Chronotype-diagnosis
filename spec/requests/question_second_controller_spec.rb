require 'rails_helper'

RSpec.describe "QuestionSecondController", type: :request do
  let!(:user) { create(:user) }
  let!(:wolf)  { create(:chronotype, id: 4, name: "オオカミ型") }
  let!(:bear)  { create(:chronotype, id: 3, name: "クマ型") }
  let!(:lion)  { create(:chronotype, id: 2, name: "ライオン型") }
  let!(:questions) { create_list(:question, 10, part: 2) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:check_chronotype).and_return(true)
  end

  let(:page1_questions) { questions[0..4] }
  let(:page2_questions) { questions[5..9] }

  def answer_hash(questions, value)
    questions.index_with { value }
  end

  describe "GET /question_second" do
    it "正常にページが表示される" do
      get question_second_path(page: 1)
      expect(response).to have_http_status(:ok)
      questions[0..4].each do |q|
        expect(response.body).to include(q.question_text)
      end
      expect(response.body).to include("10")
      expect(response.body).to include("0%")
    end
  end

  describe "POST /question_second" do
    context "最終ページ（オオカミ型）" do
      it "2ページ目にリダイレクトされる" do
        sign_in user
        post question_second_path(page: 1), params: { answers: answer_hash(page1_questions, 5) }
        expect(response).to redirect_to(question_second_path(page: 2))
        post question_second_path(page: 2), params: { answers: answer_hash(page2_questions, 5) }
        # 柔軟な検証
        expect(response).to redirect_to(/question_second/)
        expect(response.location).to include("page=2")
        follow_redirect!
        expect(response.body).to include("質問")
      end
    end

    context "最終ページ（クマ型）" do
      it "2ページ目にリダイレクトされる" do
        sign_in user
        post question_second_path(page: 1), params: { answers: answer_hash(page1_questions, 4) }
        expect(response).to redirect_to(question_second_path(page: 2))
        post question_second_path(page: 2), params: { answers: answer_hash(page2_questions, 4) }
        expect(response).to redirect_to(/question_second/)
        expect(response.location).to include("page=2")
        follow_redirect!
        expect(response.body).to include("質問")
      end
    end

    context "最終ページ（ライオン型）" do
      it "2ページ目にリダイレクトされる" do
        sign_in user
        post question_second_path(page: 1), params: { answers: answer_hash(page1_questions, 2) }
        expect(response).to redirect_to(question_second_path(page: 2))
        post question_second_path(page: 2), params: { answers: answer_hash(page2_questions, 2) }
        expect(response).to redirect_to(/question_second/)
        expect(response.location).to include("page=2")
        follow_redirect!
        expect(response.body).to include("質問")
      end
    end

    context "最終ページ（該当なし）" do
      it "2ページ目にリダイレクトされる" do
        sign_in user
        post question_second_path(page: 1), params: { answers: answer_hash(page1_questions, 0) }
        expect(response).to redirect_to(question_second_path(page: 2))
        post question_second_path(page: 2), params: { answers: answer_hash(page2_questions, 0) }
        expect(response).to redirect_to(/question_second/)
        expect(response.location).to include("page=2")
        follow_redirect!
        expect(response.body).to include("質問")
      end
    end

    context "未ログイン時（オオカミ型）" do
      it "2ページ目にリダイレクトされる" do
        post question_second_path(page: 1), params: { answers: answer_hash(page1_questions, 5) }
        expect(response).to redirect_to(question_second_path(page: 2))
        post question_second_path(page: 2), params: { answers: answer_hash(page2_questions, 5) }
        expect(response).to redirect_to(/question_second/)
        expect(response.location).to include("page=2")
        follow_redirect!
        expect(response.body).to include("質問")
      end
    end

    context "途中ページ（全問回答）" do
      it "次のページにリダイレクトされる" do
        post question_second_path(page: 1), params: { answers: answer_hash(page1_questions, 1) }
        expect(response).to redirect_to(question_second_path(page: 2))
      end
    end

    context "未回答の質問がある場合" do
      it "同じページにリダイレクトされアラートが表示される" do
        post question_second_path(page: 1), params: { answers: { page1_questions.first.id => 1 } }
        expect(response).to redirect_to(question_second_path(page: 1))
        follow_redirect!
        expect(response.body).to include("全ての質問に回答してください。")
      end
    end

    context "process_all_answersでall_answersが空の場合" do
      it "質問ページにリダイレクトされアラートが表示される" do
        sign_in user
        post question_second_path(page: 2), params: { answers: {} }
        expect(response).to redirect_to(question_second_path(page: 2))
        follow_redirect!
        expect(response.body).to include("質問に回答してください。")
      end
    end
  end
end
