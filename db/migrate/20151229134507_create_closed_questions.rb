class CreateClosedQuestions < ActiveRecord::Migration
  def change
    create_table :closed_questions do |t|
      t.string :question
      t.boolean :is_visible

      t.timestamps
    end
  end
end
