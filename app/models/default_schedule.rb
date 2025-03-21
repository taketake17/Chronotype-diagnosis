class DefaultSchedule < ApplicationRecord
  belongs_to :chronotype
  def self.generate_schedules_for_period(start_date, end_date, default_schedules)
    combined_schedules = []

    (start_date..end_date).each do |date|
      default_schedules.each do |schedule|
        start_time = Time.parse(schedule.start_time.to_s)
        end_time = Time.parse(schedule.end_time.to_s)
        start_datetime = combine_date_and_time(date, start_time)
        end_datetime = combine_date_and_time(date, end_time)

        combined_schedules << {
          id: "default_#{schedule.id}_#{date}",
          title: schedule.title,
          start: start_datetime,
          end: end_datetime,
          is_default: true
        }
      end
    end

    combined_schedules
  end

  private

  # 日付と時間を組み合わせてDateTimeオブジェクトを作成するヘルパーメソッド
  def self.combine_date_and_time(date, time)
    Time.zone.local(date.year, date.month, date.day, time.hour, time.min, time.sec)
  end
end
