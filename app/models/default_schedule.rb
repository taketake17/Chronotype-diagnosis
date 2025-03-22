class DefaultSchedule < ApplicationRecord
  belongs_to :chronotype
  def self.create_default_weekly_schedule(start_date, end_date, default_schedules)
    (start_date..end_date).flat_map do |date|
      default_schedules.map do |schedule|
        {
          id: "default_#{schedule.id}_#{date}",
          title: schedule.title,
          start: date.to_time.change(hour: schedule.start_time.hour, min: schedule.start_time.min),
          end: date.to_time.change(hour: schedule.end_time.hour, min: schedule.end_time.min),
          is_default: true
        }
      end
    end
  end


  private

  def self.combine_date_and_time(date, time)
    Time.zone.local(date.year, date.month, date.day, time.hour, time.min, time.sec)
  end
end
