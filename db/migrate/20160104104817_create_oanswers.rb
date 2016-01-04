class CreateOanswers < ActiveRecord::Migration
  def change
    create_table :oanswers do |t|
      t.text :answer
      t.integer :questionid

      t.timestamps
    end
  end
end
