class CreateHappyanswers < ActiveRecord::Migration
  def change
    create_table :happyanswers do |t|
      t.boolean :answer

      t.timestamps
    end
  end
end
