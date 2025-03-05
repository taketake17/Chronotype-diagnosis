class CreateUserChronotypes < ActiveRecord::Migration[7.2]
  def change
    create_table :user_chronotypes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chronotype, null: false, foreign_key: true
      t.references :user_answers_session, foreign_key: { to_table: :user_answers }
      t.integer :score
      t.timestamps
    end
  end
end
