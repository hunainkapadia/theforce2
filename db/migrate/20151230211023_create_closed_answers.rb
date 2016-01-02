class CreateClosedAnswers < ActiveRecord::Migration
  def change
    create_table :closed_answers do |t|
      t.boolean :Answer
      t.references :closed_question, index: true

      t.timestamps
    end
  end
end
