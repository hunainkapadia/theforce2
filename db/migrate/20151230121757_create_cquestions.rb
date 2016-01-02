class CreateCquestions < ActiveRecord::Migration
  def change
    create_table :cquestions do |t|
      t.string :question
      t.boolean :is_visible

      t.timestamps
    end
  end
end
