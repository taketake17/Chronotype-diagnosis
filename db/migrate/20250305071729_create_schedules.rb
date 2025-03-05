class CreateSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.references :default_schedule, foreign_key: true
      t.string :title
      t.timestamp :start_time
      t.timestamp :end_time
      t.boolean :is_default
      t.boolean :override_default
      t.timestamps
    end
  end
end
