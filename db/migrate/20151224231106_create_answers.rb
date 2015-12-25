class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.boolean :answer
      t.references :happinesstracker, index: true

      t.timestamps
    end
  end
end
