class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.text :question_text
      t.string :option1
      t.string :option2
      t.string :option3
      t.integer :score1
      t.integer :score2
      t.integer :score3
      t.integer :part
      t.timestamps
    end
  end
end
