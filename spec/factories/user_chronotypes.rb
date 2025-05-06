FactoryBot.define do
    factory :user_chronotype do
      association :user
      association :chronotype
      score { 20 }
    end
  end
