class AddContentToSchedules < ActiveRecord::Migration[7.2]
  def change
    add_column :schedules, :content, :text
  end
end
