# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# オオカミ型（chronotype_id: 4）のデフォルトスケジュール
[
  { title: "睡眠", start_time: '15:00', end_time: '22:00' },
  { title: "起床", start_time: '22:00', end_time: '22:30' },
  { title: "朝食", start_time: '23:00', end_time: '23:30' },
  { title: "コーヒー休憩", start_time: '02:00', end_time: '02:30' },
  { title: "昼食", start_time: '04:00', end_time: '04:30' },
  { title: "集中モード", start_time: '07:00', end_time: '09:00' },
  { title: "運動", start_time: '09:00', end_time: '10:00' },
  { title: "夕食", start_time: '11:00', end_time: '11:30' },
  { title: "就寝", start_time: '14:30', end_time: '15:00' },
  { title: "睡眠", start_time: '15:00', end_time: '23:59' }
].each do |schedule|
  DefaultSchedule.create!(
    chronotype_id: 4,
    title: schedule[:title],
    activity_type: "オオカミ型のスケジュール",
    start_time: schedule[:start_time],
    end_time: schedule[:end_time],
    day_of_week: 0
  )
end

# イルカ型（chronotype_id: 1）のデフォルトスケジュール
[
  { title: "睡眠", start_time: '15:00', end_time: '21:00' },
  { title: "起床", start_time: '21:00', end_time: '21:30' },
  { title: "運動", start_time: '21:30', end_time: '22:00' },
  { title: "朝食", start_time: '22:00', end_time: '22:30' },
  { title: "コーヒー休憩", start_time: '00:30', end_time: '01:00' },
  { title: "昼食", start_time: '03:00', end_time: '04:00' },
  { title: "集中モード", start_time: '07:00', end_time: '09:00' },
  { title: "夕食", start_time: '10:00', end_time: '11:00' },
  { title: "就寝・睡眠", start_time: '14:30', end_time: '15:00' },
  { title: "睡眠", start_time: '15:00', end_time: '23:59' }
].each do |schedule|
  DefaultSchedule.create!(
    chronotype_id: 1,
    title: schedule[:title],
    activity_type: "イルカ型のスケジュール",
    start_time: schedule[:start_time],
    end_time: schedule[:end_time],
    day_of_week: 0
  )
end

# ライオン型（chronotype_id: 2）のデフォルトスケジュール
[
  { title: "睡眠", start_time: '15:00', end_time: '20:00' },
  { title: "起床", start_time: '20:00', end_time: '20:30' },
  { title: "朝食", start_time: '20:30', end_time: '21:00' },
  { title: "軽食とコーヒー休憩", start_time: '00:00', end_time: '00:30' },
  { title: "昼食", start_time: '03:00', end_time: '03:30' },
  { title: "集中モード", start_time: '04:00', end_time: '06:00' },
  { title: "運動", start_time: '08:00', end_time: '09:00' },
  { title: "夕食", start_time: '09:00', end_time: '10:00' },
  { title: "就寝", start_time: '13:00', end_time: '13:30' },
  { title: "睡眠", start_time: '13:30', end_time: '23:59' }
].each do |schedule|
  DefaultSchedule.create!(
    chronotype_id: 2,
    title: schedule[:title],
    activity_type: "ライオン型のスケジュール",
    start_time: schedule[:start_time],
    end_time: schedule[:end_time],
    day_of_week: 0
  )
end

# クマ型（chronotype_id: 3）のデフォルトスケジュール
[
  { title: "睡眠", start_time: '15:00', end_time: '22:00' },
  { title: "起床", start_time: '22:00', end_time: '22:30' },
  { title: "朝食", start_time: '22:30', end_time: '23:00' },
  { title: "コーヒー休憩", start_time: '01:00', end_time: '01:30' },
  { title: "昼食", start_time: '03:30', end_time: '04:00' },
  { title: "昼寝", start_time: '05:00', end_time: '05:30' },
  { title: "運動", start_time: '09:00', end_time: '10:00' },
  { title: "夕食", start_time: '10:30', end_time: '11:00' },
  { title: "就寝", start_time: '13:30', end_time: '14:00' },
  { title: "睡眠", start_time: '14:00', end_time: '23:59' }
].each do |schedule|
  DefaultSchedule.create!(
    chronotype_id: 3,
    title: schedule[:title],
    activity_type: "クマ型のスケジュール",
    start_time: schedule[:start_time],
    end_time: schedule[:end_time],
    day_of_week: 0
  )
end
