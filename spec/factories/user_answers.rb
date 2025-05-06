# spec/factories/user_answers.rb
FactoryBot.define do
    factory :user_answer do
      association :user
      association :question
      answer { "青" }
    end
  end
