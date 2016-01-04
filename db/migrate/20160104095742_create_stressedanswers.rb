class CreateStressedanswers < ActiveRecord::Migration
  def change
    create_table :stressedanswers do |t|
      t.boolean :answer

      t.timestamps
    end
  end
end
