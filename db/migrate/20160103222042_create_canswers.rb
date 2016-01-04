class CreateCanswers < ActiveRecord::Migration
  def change
    create_table :canswers do |t|
      t.boolean :answer
      t.references :closed_question, index: true

      t.timestamps
    end
  end
end
