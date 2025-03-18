class DefaultSchedule < ApplicationRecord
  belongs_to :chronotype

  scope :daily, -> { where(day_of_week: 0) }

  def start_time
    self[:start_time]&.strftime("%H:%M")
  end

  def end_time
    self[:end_time]&.strftime("%H:%M")
  end

  def start_time=(time_string)
    self[:start_time] = Time.zone.parse(time_string)
  end

  def end_time=(time_string)
    self[:end_time] = Time.zone.parse(time_string)
  end
end
