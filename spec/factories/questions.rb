FactoryBot.define do
    factory :question do
      sequence(:question_text) { |n| "質問#{n}" }
      option1 { "選択肢1" }
      option2 { "選択肢2" }
      option3 { "選択肢3" }
      score1 { 1 }
      score2 { 2 }
      score3 { 3 }
      part { 1 }
    end
  end
