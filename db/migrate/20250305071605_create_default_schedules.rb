class CreateDefaultSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :default_schedules do |t|
      t.references :chronotype, null: false, foreign_key: true
      t.string :activity_type
      t.time :start_time
      t.time :end_time
      t.integer :day_of_week
      t.integer :priority

      t.timestamps
    end
  end
end
