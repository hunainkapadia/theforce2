class CreateOpenQuestions < ActiveRecord::Migration
  def change
    create_table :open_questions do |t|
      t.string :question
      t.string :createdby
      t.date :createdfordate

      t.timestamps
    end
  end
end
