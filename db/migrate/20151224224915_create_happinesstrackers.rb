class CreateHappinesstrackers < ActiveRecord::Migration
  def change
    create_table :happinesstrackers do |t|
      t.string :question

      t.timestamps
    end
  end
end
