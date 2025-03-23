class DefaultSchedule < ApplicationRecord
  belongs_to :chronotype

  def self.create_default_weekly_schedule(start_date, end_date, default_schedules)
    (start_date..end_date).flat_map do |date|
      default_schedules.map do |schedule|
        start_time = combine_date_and_time(date, schedule.start_time)
        end_time = combine_date_and_time(date, schedule.end_time)
        
        if end_time < start_time
          end_time = end_time + 1.day
        end

        {
          id: "default_#{schedule.id}_#{date}",
          title: schedule.title,
          start: start_time,
          end: end_time,
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
