class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :trivia_question, foreign_key: true
      t.string :answer_text
      t.boolean :correct

      t.timestamps
    end
  end
end
