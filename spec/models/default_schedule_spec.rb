require 'rails_helper'

RSpec.describe DefaultSchedule, type: :model do
  describe '.create_default_weekly_schedule' do
    let(:chronotype) { DefaultSchedule.reflect_on_association(:chronotype).klass.create!(name: '朝型') }
    let(:schedule1) do
      DefaultSchedule.create!(
        chronotype: chronotype,
        title: 'モーニングルーティン',
        start_time: Time.zone.parse('07:00'),
        end_time: Time.zone.parse('08:00')
      )
    end
    let(:schedule2) do
      DefaultSchedule.create!(
        chronotype: chronotype,
        title: 'ナイトルーティン',
        start_time: Time.zone.parse('23:00'),
        end_time: Time.zone.parse('01:00') # 日付をまたぐ
      )
    end

    let(:start_date) { Date.new(2024, 5, 1) }
    let(:end_date)   { Date.new(2024, 5, 2) }

    it '指定した期間分、日ごとにスケジュールを生成する' do
      result = DefaultSchedule.create_default_weekly_schedule(start_date, end_date, [ schedule1 ])
      expect(result.size).to eq 2 # 2日分
      expect(result[0][:title]).to eq 'モーニングルーティン'
      expect(result[1][:title]).to eq 'モーニングルーティン'
      expect(result[0][:is_default]).to be true
    end

    it '日付をまたぐスケジュールも正しく生成される' do
      result = DefaultSchedule.create_default_weekly_schedule(start_date, end_date, [ schedule2 ])
      first = result.first
      expect(first[:start].hour).to eq 23
      expect(first[:end].hour).to eq 1
      expect(first[:end].to_date).to eq first[:start].to_date + 1 # 日付をまたいでいることを確認
    end
  end
end
