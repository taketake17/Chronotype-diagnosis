# spec/models/user_answer_spec.rb
require 'rails_helper'

RSpec.describe UserAnswer, type: :model do
  describe "associations" do
    it "belongs to user" do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

    it "belongs to question" do
      assoc = described_class.reflect_on_association(:question)
      expect(assoc.macro).to eq :belongs_to
    end
  end

  describe "validation" do
    let(:user) { User.create!(email: "test@example.com", password: "password", username: "テストユーザー") }
    let(:question) { Question.create!(question_text: "好きな色は？", option1: "赤", option2: "青", option3: "緑", score1: 1, score2: 2, score3: 3, part: 1) }

    it "is valid with valid attributes" do
      user_answer = UserAnswer.new(user: user, question: question, selected_option: 2)
      expect(user_answer).to be_valid
    end

    it "is invalid without a user" do
      user_answer = UserAnswer.new(user: nil, question: question, selected_option: 1)
      expect(user_answer).not_to be_valid
    end

    it "is invalid without a question" do
      user_answer = UserAnswer.new(user: user, question: nil, selected_option: 1)
      expect(user_answer).not_to be_valid
    end

    it "is invalid without selected_option" do
      user_answer = UserAnswer.new(user: user, question: question, selected_option: nil)
      expect(user_answer).not_to be_valid
    end
  end
end
