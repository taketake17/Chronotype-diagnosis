require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:user) { User.create!(email: 'test@example.com', password: 'password', username: 'テストユーザー') }

  describe 'バリデーション' do
    it '有効なファクトリであれば有効' do
      schedule = Schedule.new(user: user, title: 'テスト予定', start_time: Time.zone.now, end_time: Time.zone.now + 1.hour)
      expect(schedule).to be_valid
    end

    it 'titleがなければ無効' do
      schedule = Schedule.new(user: user, title: nil, start_time: Time.zone.now, end_time: Time.zone.now + 1.hour)
      expect(schedule).not_to be_valid
      expect(schedule.errors[:title]).not_to be_empty
    end

    it 'start_timeがなければ無効' do
      schedule = Schedule.new(user: user, title: 'テスト予定', start_time: nil, end_time: Time.zone.now + 1.hour)
      expect(schedule).not_to be_valid
      expect(schedule.errors[:start_time]).not_to be_empty
    end

    it 'end_timeがなければ無効' do
      schedule = Schedule.new(user: user, title: 'テスト予定', start_time: Time.zone.now, end_time: nil)
      expect(schedule).not_to be_valid
      expect(schedule.errors[:end_time]).not_to be_empty
    end

    it 'userがなければ無効' do
      schedule = Schedule.new(user: nil, title: 'テスト予定', start_time: Time.zone.now, end_time: Time.zone.now + 1.hour)
      expect(schedule).not_to be_valid
      expect(schedule.errors[:user]).not_to be_empty
    end
  end

  describe 'アソシエーション' do
    it 'Userに属している' do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
