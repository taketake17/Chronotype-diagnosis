class AddTitleToDefaultSchedules < ActiveRecord::Migration[7.2]
  def change
     add_column :default_schedules, :title, :string
  end
end
