class CreateUserAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :user_answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :selected_option, null: false
      t.timestamps
    end
  end
end
