FactoryBot.define do
    factory :schedule do
      association :user
      title { "テスト予定" }
      start_time { Time.zone.now }
      end_time { Time.zone.now + 1.hour }
      content { "テスト内容" }
    end
  end
